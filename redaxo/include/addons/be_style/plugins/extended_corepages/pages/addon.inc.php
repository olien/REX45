<?php
/**
 * extended_corepages - Redaxo be_style Plugin
 *
 * @version 1.3.2
 * @package redaxo 4.4.x/4.5.x
 */


// GET PARAMS
////////////////////////////////////////////////////////////////////////////////
$mypage     = 'extended_corepages';
$myparent   = implode(array_slice(explode(DIRECTORY_SEPARATOR,__FILE__), -5, 1));
$myroot     = $REX['INCLUDE_PATH'].'/addons/'.$myparent.'/plugins/'.$mypage.'/';
$page       = rex_request('page', 'string');
$subsubpage = rex_request('subsubpage', 'string');
$func       = rex_request('func', 'string');
$topic      = rex_request('topic', 'string');


// PAGE HEAD
////////////////////////////////////////////////////////////////////////////////
require $REX['INCLUDE_PATH'] . '/layout/top.php';

rex_title($I18N->msg('addon').' <span style="color:silver;font-size:0.4em;">'.$myparent.'::'.$mypage.' '.$REX['ADDON']['plugins'][$myparent]['version'][$mypage].'</span>');

// RequestVars
////////////////////////////////////////////////////////////////////////////////
$addonname  = rex_request('addonname', 'string');
$pluginname = rex_request('pluginname', 'string');
$subpage    = rex_request('subpage', 'string');
$info       = htmlspecialchars(stripslashes(rex_request('info', 'string')));
$info       = $info != '' ? explode('|',$info) : array();
// READ CONFIG
////////////////////////////////////////////////////////////////////////////////
$ADDONS    = rex_read_addons_folder();
$PLUGINS   = array();
foreach($ADDONS as $_addon) {
  $PLUGINS[$_addon] = rex_read_plugins_folder($_addon);
}

$addonname  = array_search($addonname, $ADDONS) !== false ? $addonname : '';
if($addonname != '') {
  $pluginname = array_search($pluginname, $PLUGINS[$addonname]) !== false ? $pluginname : '';
} else {
  $pluginname = '';
}

$warning = array();

if($pluginname != '') {
  $addonManager = new rex_pluginManager($PLUGINS, $addonname);
} else {
  $addonManager = new rex_addonManager($ADDONS);
}

// I18N
////////////////////////////////////////////////////////////////////////////////
$I18N->appendFile($myroot.'lang/');
foreach((array) glob($myroot.'lang/*.'.$REX['LANG'].'.textile') as $file) {
  if(file_exists($file)) {
    $string = rex_get_file_contents($file);
    $string = OOAddon::isActivated('textile') ? rex_a79_textile($string) : nl2br($string);
    $I18N->addMsg( 'extended_corepages_'.implode(array_slice(explode('.',pathinfo($file,PATHINFO_FILENAME)), -2, 1)), $string);
  }
}

// HELPPAGE
////////////////////////////////////////////////////////////////////////////////
if ($subpage == 'help' && $addonname != '')
{
  if($pluginname != '')
  {
    $helpfile    = rex_plugins_folder($addonname, $pluginname);
    $version     = OOPlugin::getVersion($addonname, $pluginname);
    $author      = OOPlugin::getAuthor($addonname, $pluginname);
    $supportPage = OOPlugin::getSupportPage($addonname, $pluginname);
    $addonname   = $addonname .' / '. $pluginname;
  }
  else
  {
    $helpfile    = rex_addons_folder($addonname);
    $version     = OOAddon::getVersion($addonname);
    $author      = OOAddon::getAuthor($addonname);
    $supportPage = OOAddon::getSupportPage($addonname);
  }
  $helpfile                 .= DIRECTORY_SEPARATOR.'help.inc.php';

  $credits                   = '';
  $credits                  .= $I18N->msg("credits_name") .': <span>'. htmlspecialchars($addonname) .'</span><br />';
  if($version) $credits     .= $I18N->msg("credits_version") .': <span>'. $version .'</span><br />';
  if($author) $credits      .= $I18N->msg("credits_author") .': <span>'. htmlspecialchars($author) .'</span><br />';
  if($supportPage) $credits .= $I18N->msg("credits_supportpage") .': <span><a href="http://'.$supportPage.'" onclick="window.open(this.href); return false;">'. $supportPage .'</a></span><br />';

  echo '<div class="rex-area">
        <h3 class="rex-hl2">'.$I18N->msg("addon_help").' '.$addonname.'</h3>
        <div class="rex-area-content extended_corepages">';
  if (!is_file($helpfile))
  {
    echo '<p>'. $I18N->msg("addon_no_help_file") .'</p>';
  }
  else
  {
    include $helpfile;
  }
  echo '<br />
        <p id="rex-addon-credits">'. $credits .'</p>
        </div>
        <div class="rex-area-footer">
          <p><a href="index.php?page=addon">'.$I18N->msg("addon_back").'</a></p>
        </div>
      </div>
      <div class="rex-clearer"></div>
      <br/>';
}

if ($subpage == 'help' && $topic == 'symlinks')
{
    echo '<div class="rex-area">
        <h3 class="rex-hl2">Symlinks FAQ</h3>
        <div class="rex-area-content extended_corepages">
          '.$I18N->msg("extended_corepages_symlink_help").'
        </div>
        <div class="rex-area-footer">
          <p><a href="index.php?page=addon">'.$I18N->msg("addon_back").'</a></p>
        </div>
      </div>
      <div class="rex-clearer"></div>
      <br/>';
}



function isSymlinked($addon, $plugin=false)
{
  global $REX;
  $dir = !$plugin
       ? $REX['FRONTEND_PATH'].'/files/addons/'.$addon
       : $REX['FRONTEND_PATH'].'/files/addons/'.$addon.'/plugins/'.$plugin;
  if(is_link($dir)){
    return true;
  }elseif(is_link($dir.'/')){
    return true;
  }
  return false;
}

function hasInstallSql($addon, $plugin=false)
{
  global $REX;
  $sql = !$plugin
       ? $REX['INCLUDE_PATH'].'/addons/'.$addon.'/install.sql'
       : $REX['INCLUDE_PATH'].'/addons/'.$addon.'/plugins/'.$plugin.'/install.sql';
  return file_exists($sql);
}

// FUNCTIONS
////////////////////////////////////////////////////////////////////////////////
if ($addonname != '')
{
  $install   = rex_get('install', 'int', -1);
  $activate  = rex_get('activate', 'int', -1);
  $uninstall = rex_get('uninstall', 'int', -1);
  $delete    = rex_get('delete', 'int', -1);
  $dosymlink = rex_get('dosymlink', 'int', -1);

  $redirect = false;

  // SYMLINK
  //////////////////////////////////////////////////////////////////////////////
  if ($dosymlink == 1)
  {                                                                                                                     #FB::group('$dosymlink == 1', array("Collapsed"=>false));
    $target = $link = $linked = false;

    // IS PLUGIN -> ASSEMBLE PATHES
    ////////////////////////////////////////////////////////////////////////////
    if($pluginname!='')
    {
      if(!isSymlinked($addonname,$pluginname)){
        $target = $REX['INCLUDE_PATH'].'/addons/'.$addonname.'/plugins/'.$pluginname.'/files';                          #FB::log($target,' $target');
        $target = (!file_exists($target) || !is_dir($target)) ? false : $target;
        $link   = $REX['FRONTEND_PATH'].'/files/addons/'.$addonname.'/plugins/'.$pluginname;
      }else{
        $linked = true;
      }
    }

    // IS ADDON -> ASSEMBLE PATHES
    ////////////////////////////////////////////////////////////////////////////
    elseif($addonname!='')
    {
      if(!isSymlinked($addonname)){
        $target = $REX['INCLUDE_PATH'].'/addons/'.$addonname.'/files';                                                  #FB::log($target,' $target');
        $target = (!file_exists($target) || !is_dir($target)) ? false : $target;
        $link   = $REX['FRONTEND_PATH'].'/files/addons/'.$addonname;
      }else{
        $linked = true;
      }
    }                                                                                                                   #FB::log($target,' $target');         FB::log($link,' $link');         FB::log($linked,' $linked');

    // CREATE SYMLINK
    ////////////////////////////////////////////////////////////////////////////
    if($target && !$linked){                                                                                            #FB::log('create symlink');
      if(file_exists($link) && is_dir($link)){
        $renamed = $link.'~';
        while(file_exists($renamed)){
          $renamed = $renamed.'~';
        }
        if(!rename($link,$renamed)){                                                                                    #FB::warn('FAIL: rename('.$link.',"~~~"'.$link.')');
          $warning[] = 'rename of original asset folder failed';
        }else{
          $info[] = 'original asset folder renamad to: '.$renamed;
        }
      }
      if(!symlink($target,$link)){                                                                                      #FB::warn('FAIL: symlink('.$target.','.$link.')');
        $warning[] = 'creating symlink to asset folder failed';
      }
    }else{                                                                                                              #FB::log('CANNOT create symlink: $target:'.(string)$target.', $linked:'.(string)$linked);
      if($linked){
        $warning[] = 'cannot creat symlink - asset folder allready symlinked';
      }else{
        $warning[] = 'cannot creat symlink - invalid target folder';
      }
    }

    $redirect = true;
  }

  // UNLINK
  //////////////////////////////////////////////////////////////////////////////
  elseif ($dosymlink == 0)
  {                                                                                                                     #FB::group('$dosymlink == 0', array("Collapsed"=>false));
    $target = $link = $linked = false;

    // IS PLUGIN -> ASSEMBLE PATHES
    ////////////////////////////////////////////////////////////////////////////
    if($pluginname!='')
    {
      if(isSymlinked($addonname,$pluginname)){
        $target = $REX['INCLUDE_PATH'].'/addons/'.$addonname.'/plugins/'.$pluginname.'/files';                          #FB::log($target,' $target');
        $target = (!file_exists($target) || !is_dir($target)) ? false : $target;
        $link   = $REX['FRONTEND_PATH'].'/files/addons/'.$addonname.'/plugins/'.$pluginname;
        $linked = true;
      }
    }

    // IS ADDON -> ASSEMBLE PATHES
    ////////////////////////////////////////////////////////////////////////////
    elseif($addonname!='')
    {
      if(isSymlinked($addonname)){
        $target = $REX['INCLUDE_PATH'].'/addons/'.$addonname.'/files';                                                  #FB::log($target,' $target');
        $target = (!file_exists($target) || !is_dir($target)) ? false : $target;
        $link   = $REX['FRONTEND_PATH'].'/files/addons/'.$addonname;
        $linked = true;
      }
    }                                                                                                                   #FB::log($target,' $target');         FB::log($link,' $link');         FB::log($linked,' $linked');

    // UNLINK
    ////////////////////////////////////////////////////////////////////////////
    if($linked)
    {
      if(!unlink($link)){
        $warning[] = 'cannot remove symlink';
      }else{
        $info[] = 'symlink removed';
      }
      if($pluginname!=''){
        $ret = $addonManager->install($pluginname,false);
        if($ret == 1){
          $info[] = 'restored native assets';
        }else{
          $warning[] = 'could not restore native assets';
        }
      }else{
        $ret = $addonManager->install($addonname,false);
        if($ret == 1){
          $info[] = 'restored native assets';
        }else{
          $warning[] = 'could not restore native assets';
        }
      }
    }
    else
    {
      $warning[] = 'assets not symlinked';
    }

    $redirect = true;
  }

  // ADDON INSTALL
  //////////////////////////////////////////////////////////////////////////////
  elseif ($install == 1)
  {
    if($pluginname != '')
    {
      if(($warning = $addonManager->install($pluginname)) === true)
      {
        $info[] = $I18N->msg("plugin_installed", $pluginname);

        if(($warning = $addonManager->activate($pluginname)) === true)
        {
          $info[]   = $I18N->msg("plugin_activated", $pluginname);
          $redirect = true;
        }
      }
    }
    else if (($warning = $addonManager->install($addonname)) === true)
    {
      $info[] = $I18N->msg("addon_installed", $addonname);

      if (($warning = $addonManager->activate($addonname)) === true)
      {
        $info[]   = $I18N->msg("addon_activated", $addonname);
        $redirect = true;
      }
    }

  }
  // ADDON ACTIVATE
  //////////////////////////////////////////////////////////////////////////////
  elseif ($activate == 1)
  {
    if($pluginname != '')
    {
      if(($warning = $addonManager->activate($pluginname)) === true)
      {
        $info[]   = $I18N->msg("plugin_activated", $pluginname);
        $redirect = true;
      }
    }
    else if (($warning = $addonManager->activate($addonname)) === true)
    {
      $info[]   = $I18N->msg("addon_activated", $addonname);
      $redirect = true;
    }
  }
  // ADDON DEACTIVATE
  //////////////////////////////////////////////////////////////////////////////
  elseif ($activate == 0)
  {
    if($pluginname != '')
    {
      if (($warning = $addonManager->deactivate($pluginname)) === true)
      {
        $info[]   = $I18N->msg("plugin_deactivated", $pluginname);
        $redirect = true;
      }
    }
    else if (($warning = $addonManager->deactivate($addonname)) === true)
    {
      $info[]   = $I18N->msg("addon_deactivated", $addonname);
      $redirect = true;
    }
  }
  // ADDON UNINSTALL
  //////////////////////////////////////////////////////////////////////////////
  elseif ($uninstall == 1)
  {
    if($pluginname != '')
    {
      if (($warning = $addonManager->uninstall($pluginname)) === true)
      {
        $info[]   = $I18N->msg("plugin_uninstalled", $pluginname);
        $redirect = true;
      }
    }
    else if (($warning = $addonManager->uninstall($addonname)) === true)
    {
      $info[]   = $I18N->msg("addon_uninstalled", $addonname);
      $redirect = true;
    }
  }
  // ADDON DELETE
  //////////////////////////////////////////////////////////////////////////////
  elseif ($delete == 1)
  {
    if($pluginname != '')
    {
      if (($warning = $addonManager->delete($pluginname)) === true)
      {
        $info[]   = $I18N->msg("plugin_deleted", $pluginname);
        $redirect = true;
      }
    }
    else if (($warning = $addonManager->delete($addonname)) === true)
    {
      $info[]   = $I18N->msg("addon_deleted", $addonname);
      $redirect = true;
    }
  }

  if ($redirect)
  {
    header('Location: index.php?page=addon&info='. implode('|',$info));
    exit;
  }
}

// OUT
////////////////////////////////////////////////////////////////////////////////
$warning = !is_array($warning) ? (array) $warning : $warning;

if ($page == 'addon')
{
  // Vergleiche Addons aus dem Verzeichnis addons/ mit den Eintraegen in include/addons.inc.php
  // Wenn ein Addon in der Datei fehlt oder nicht mehr vorhanden ist, aendere den Dateiinhalt.
  if (count(array_diff($ADDONS, OOAddon::getRegisteredAddons())) > 0 ||
      count(array_diff(OOAddon::getRegisteredAddons(), $ADDONS)) > 0)
  {
    if (($state = rex_generateAddons($ADDONS)) !== true)
    {
      $warning[] = $state;
    }
  }

  // Vergleiche plugins aus dem Verzeichnis plugins/ mit den Eintraegen in include/plugins.inc.php
  // Wenn ein plugin in der Datei fehlt oder nicht mehr vorhanden ist, aendere den Dateiinhalt.
  foreach($ADDONS as $addon)
  {
    if (count(array_diff($PLUGINS[$addon], OOPlugin::getRegisteredPlugins($addon))) > 0 ||
        count(array_diff(OOPlugin::getRegisteredPlugins($addon), $PLUGINS[$addon])) > 0)
    {
      if (($state = rex_generateplugins($PLUGINS)) !== true)
      {
        $warning[] = $state;
        break;
      }
    }
  }

  if (count($info) > 0) {
    foreach((array) $info as $i) {
      if($i != '') {
        echo rex_info($i);
      }
    }
  }

  if (count($warning) > 0) {
    foreach((array) $warning as $w) {
      if($w != '') {
        echo rex_warning($w);
      }
    }
  }

  if (!isset ($user_id))
  {
    $user_id = '';
  }

  echo '
      <table class="rex-table extended_corepages" summary="'.$I18N->msg("addon_summary").'">
      <caption>'.$I18N->msg("addon_caption").'</caption>
      <colgroup>
        <col width="20">
        <col width="*">
        <col width="80">
        <col width="90">
        <col width="85">
        <col width="90">
        <col width="60">
      </colgroup>
      <thead>
        <tr>
          <th class="rex-icon rex-col-a">&nbsp;</th>
          <th class="rex-col-b">'.$I18N->msg("addon_hname").'</th>
          <th class="rex-col-s">Assets <span>[<a href="index.php?page=addon&amp;subpage=help&amp;topic=symlinks">?</a>]</span></th>
          <th class="rex-col-c">'.$I18N->msg("addon_hinstall").'</th>
          <th class="rex-col-d">'.$I18N->msg("addon_hactive").'</th>
          <th class="rex-col-e" colspan="2">'.$I18N->msg("addon_hdelete").'</th>
        </tr>
      </thead>
      <tbody>';

  foreach ($ADDONS as $addon)
  {
    $addonurl = 'index.php?page=addon&amp;addonname='.$addon.'&amp;';

    $symlinked = $hasplugins = false;
    $symlink   = '<a href="'.$addonurl .'dosymlink=1">symlink</a>' ;
    if(isSymlinked($addon)){
      $symlink = '<a href="'.$addonurl .'dosymlink=0">unlink</a>' ;
      $symlinked = true;
    }
    if(!is_dir($REX['INCLUDE_PATH'].'/addons/'.$addon.'/files')){
      $symlink    = '<strike title="no dirs to symlink">symlink</strike>' ;
    }
    if(count($PLUGINS[$addon])>0){
      $symlink    = '<strike title="addon has plugins: symlinking disabled">symlink</strike>' ;
      $hasplugins = true;
    }

    if (OOAddon::isSystemAddon($addon))
    {
      $delete = '<strike title="'.$I18N->msg("addon_systemaddon").'">'.$I18N->msg("addon_delete").'</strike>';
    }
    else
    {
      $delete = '<a href="'. $addonurl .'delete=1" onclick="return confirm(\''.htmlspecialchars($I18N->msg('addon_delete_question', $addon)).'\');">'.$I18N->msg("addon_delete").'</a>';
    }

    if (OOAddon::isInstalled($addon))
    {
      $install = hasInstallSql($addon)
               ? '<a href="'. $addonurl .'install=1" onclick="return confirm(\''.htmlspecialchars($I18N->msg("addon_reinstall_question", $addon)).'\');">'.$I18N->msg("addon_reinstall").'</a>'
               : '<a href="'. $addonurl .'install=1">'.$I18N->msg("addon_reinstall").'</a>';
      if(count(OOPlugin::getInstalledPlugins($addon)) > 0)
      {
        $uninstall = '<strike title="'.$I18N->msg("plugin_plugins_installed").'">'.$I18N->msg("addon_uninstall").'</strike>';
        $delete = '<strike title="'.$I18N->msg("plugin_plugins_installed").'">'.$I18N->msg("addon_delete").'</strike>';
      }
      else
      {
        $uninstall = '<a href="'. $addonurl .'uninstall=1" onclick="return confirm(\''.htmlspecialchars($I18N->msg("addon_uninstall_question", $addon)).'\');">'.$I18N->msg("addon_uninstall").'</a>';
      }
    }
    else
    {
      $install = '<a href="'. $addonurl .'install=1">'.$I18N->msg("addon_install").'</a>';
      $uninstall = '<strike title="'.$I18N->msg("addon_notinstalled").'">'.$I18N->msg("addon_uninstall").'</strike>';
    }

    if (OOAddon::isActivated($addon))
    {
      $state_class = 'active';
      $status = '<a href="'. $addonurl .'activate=0">'.$I18N->msg("addon_deactivate").'</a>';
    }
    elseif (OOAddon::isInstalled($addon))
    {
      $state_class = 'inactive';
      $status = '<a href="'. $addonurl .'activate=1">'.$I18N->msg("addon_activate").'</a>';
    }
    else
    {
      $state_class = 'notinstalled';
      $status = '<strike title="'.$I18N->msg("addon_notinstalled").'">'.$I18N->msg("addon_activate").'</strike>';
    }

    echo '
        <tr class="rex-addon '.$state_class.' '.($hasplugins ? 'hasplugins' : '').'">
          <td class="rex-icon rex-col-a"><span class="rex-i-element rex-i-addon"><span class="rex-i-element-text">'. htmlspecialchars($addon) .'</span></span></td>
          <td class="rex-col-b">'.htmlspecialchars($addon).' [<a href="index.php?page=addon&amp;subpage=help&amp;addonname='.$addon.'">?</a>]</td>
          <td class="rex-col-s '.($symlinked ? 'symlinked' : '').'"><span>'.$symlink.'</span></td>
          <td class="rex-col-c">'.$install.'</td>
          <td class="rex-col-d">'.$status.'</td>
          <td class="rex-col-e">'.$uninstall.'</td>
          <td class="rex-col-f">'.$delete.'</td>
        </tr>'."\n   ";

    if(OOAddon::isAvailable($addon))
    {
      foreach($PLUGINS[$addon] as $plugin)
      {
        $pluginurl = 'index.php?page=addon&amp;addonname='.$addon.'&amp;pluginname='. $plugin .'&amp;';

        $symlink   = '<a href="'.$pluginurl.'dosymlink=1">symlink</a>' ;
        $symlinked = false;
        if(isSymlinked($addon,$plugin)){
          $symlink = '<a href="'.$pluginurl.'dosymlink=0">unlink</a>' ;
          $symlinked = true;
        }

        $delete = '<a href="'. $pluginurl .'delete=1" onclick="return confirm(\''.htmlspecialchars($I18N->msg('plugin_delete_question', $plugin)).'\');">'.$I18N->msg("addon_delete").'</a>';

        if (OOPlugin::isInstalled($addon, $plugin))
        {
          $install = hasInstallSql($addon, $plugin)
                   ? '<a href="'. $pluginurl .'install=1" onclick="return confirm(\''.htmlspecialchars($I18N->msg("addon_reinstall_question", $addon)).'\');">'.$I18N->msg("addon_reinstall").'</a>'
                   : '<a href="'. $pluginurl .'install=1">'.$I18N->msg("addon_reinstall").'</a>';
          $uninstall = '<a href="'. $pluginurl .'uninstall=1" onclick="return confirm(\''.htmlspecialchars($I18N->msg("plugin_uninstall_question", $plugin)).'\');">'.$I18N->msg("addon_uninstall").'</a>';
        }
        else
        {
          $install = '<a href="'. $pluginurl .'install=1">'.$I18N->msg("addon_install").'</a>';
          $uninstall = '<strike title="'.$I18N->msg("addon_notinstalled").'">'.$I18N->msg("addon_uninstall").'</strike>';
        }

        if (OOPlugin::isActivated($addon, $plugin))
        {
          $state_class = 'active';
          $status = '<a href="'. $pluginurl .'activate=0">'.$I18N->msg("addon_deactivate").'</a>';
        }
        elseif (OOPlugin::isInstalled($addon, $plugin))
        {
          $state_class = 'inactive';
          $status = '<a href="'. $pluginurl .'activate=1">'.$I18N->msg("addon_activate").'</a>';
        }
        else
        {
          $state_class = 'notinstalled';
          $status = '<strike title="'.$I18N->msg("addon_notinstalled").'">'.$I18N->msg("addon_activate").'</strike>';
        }

        echo '
            <tr class="rex-plugin '.$state_class.'">
              <td class="rex-icon rex-col-a"><span class="rex-i-element rex-i-plugin"><span class="rex-i-element-text">'. htmlspecialchars($plugin) .'</span></span></td>
              <td class="rex-col-b">'.htmlspecialchars($plugin).' [<a href="index.php?page=addon&amp;subpage=help&amp;addonname='.$addon.'&amp;pluginname='.$plugin.'">?</a>]</td>
              <td class="rex-col-s '.($symlinked ? 'symlinked' : '').'">'.$symlink.'</td>
              <td class="rex-col-c">'.$install.'</td>
              <td class="rex-col-d">'.$status.'</td>
              <td class="rex-col-e">'.$uninstall.'</td>
              <td class="rex-col-f">'.$delete.'</td>
            </tr>'."\n   ";
      }
    }
  }

  echo '</tbody>
      </table>';
}

echo '<style>'.rex_get_file_contents($myroot . 'assets/addon.css').'</style>';
echo '<script>'.rex_get_file_contents($myroot . 'assets/addon.js').'</script>';

require $REX['INCLUDE_PATH'] . '/layout/bottom.php';
