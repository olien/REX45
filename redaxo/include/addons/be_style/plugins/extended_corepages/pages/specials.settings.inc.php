<?php
/**
 * extended_corepages - Redaxo be_style Plugin
 *
 * @version 1.3.2
 * @package redaxo 4.4.x/4.5.x
 */


// INIT VARS
////////////////////////////////////////////////////////////////////////////////
$mypage   = 'extended_corepages';
$myparent = implode(array_slice(explode(DIRECTORY_SEPARATOR,__FILE__), -5, 1));
$myroot   = $REX['INCLUDE_PATH'].'/addons/'.$myparent.'/plugins/'.$mypage.'/';

$info     = '';
$warning  = '';


// I18N
////////////////////////////////////////////////////////////////////////////////
$I18N->appendFile($myroot.'lang/');

// REACTIVATE SETUP
////////////////////////////////////////////////////////////////////////////////
if ($func == 'setup')
{
  $master_file = $REX['INCLUDE_PATH'].'/master.inc.php';
  $cont = rex_get_file_contents($master_file);
  $cont = preg_replace("@(REX\['SETUP'\].?\=.?)[^;]*@", '$1true', $cont);
  // echo nl2br(htmlspecialchars($cont));
  if (rex_put_file_contents($master_file, $cont) !== false)
  {
    $info = $I18N->msg('setup_error1', '<a href="index.php">', '</a>');
  }
  else
  {
    $warning = $I18N->msg('setup_error2');
  }
}


// GENERATE ALL
////////////////////////////////////////////////////////////////////////////////
elseif ($func == 'generate')
{
  // generate all articles,cats,templates,caches
  $info = rex_generateAll();
}


// GENERATE ALL BUT IMAGES
////////////////////////////////////////////////////////////////////////////////
elseif ($func == 'generate_but_images')
{
  // ----------------------------------------------------------- generated löschen
  $dir   = new RecursiveDirectoryIterator($REX['GENERATED_PATH']);
  $ite   = new RecursiveIteratorIterator($dir);
  $files = new RegexIterator($ite, '@^.*\.(?!jpg$|jpeg$|png$|gif$)[^.]+$@i', RegexIterator::GET_MATCH);
  foreach ($files as $file)
  {
    $file = $file[0];
    if(is_dir($file)) {
      continue;
    }
    if(!unlink($file)) {
      trigger_error('extended_corepages: could not unlink '.$file, E_USER_WARNING);
    }
  }

  // ----------------------------------------------------------- generiere clang
  if(($MSG = rex_generateClang()) !== TRUE)
  {
    $info = $MSG;
  }
  else
  {
    // ----------------------------------------------------------- message
    $MSG = $I18N->msg('delete_cache_but_images_message');

    // ----- EXTENSION POINT
    $MSG = rex_register_extension_point('ALL_GENERATED', $MSG);

    $info = $MSG;
  }
}


// SAVE SPECIALS FORM
////////////////////////////////////////////////////////////////////////////////
elseif ($func == 'updateinfos')
{
  $neu_startartikel       = rex_post('neu_startartikel', 'int');
  $neu_notfoundartikel    = rex_post('neu_notfoundartikel', 'int');
  $neu_defaulttemplateid  = rex_post('neu_defaulttemplateid', 'int');
  $neu_lang               = rex_post('neu_lang', 'string');
  // ' darf nichtg escaped werden, da in der Datei der Schlüssel nur zwischen " steht
  $neu_error_emailaddress = str_replace("\\'", "'", rex_post('neu_error_emailaddress', 'string'));
  $neu_SERVER             = str_replace("\\'", "'", rex_post('neu_SERVER', 'string'));
  $neu_SERVERNAME         = str_replace("\\'", "'", rex_post('neu_SERVERNAME', 'string'));
  $neu_modrewrite         = rex_post('neu_modrewrite', 'string');

  $neu_session_duration   = rex_post('neu_session_duration', 'int') < 300 ? 300 : rex_post('neu_session_duration', 'int');
  $neu_use_gzip           = rex_post('neu_use_gzip', 'string');
  $neu_use_etag           = rex_post('neu_use_etag', 'string');
  $neu_use_last_modified  = rex_post('neu_use_last_modified', 'string');
  $neu_use_md5            = rex_post('neu_use_md5', 'string');

  $startArt               = OOArticle::getArticleById($neu_startartikel);
  $notFoundArt            = OOArticle::getArticleById($neu_notfoundartikel);

  $REX['LANG']            = $neu_lang;
  $master_file            = $REX['INCLUDE_PATH'] .'/master.inc.php';
  $cont                   = rex_get_file_contents($master_file);

  if(!OOArticle::isValid($startArt))
  {
    $warning .= $I18N->msg('settings_invalid_sitestart_article')."<br />";
  }else
  {
    $cont = preg_replace("@(REX\['START_ARTICLE_ID'\].?\=.?)[^;]*@", '${1}'.strtolower($neu_startartikel), $cont);
    $REX['START_ARTICLE_ID'] = $neu_startartikel;
  }

  if(!OOArticle::isValid($notFoundArt))
  {
    $warning .= $I18N->msg('settings_invalid_notfound_article')."<br />";
  }else
  {
    $cont = preg_replace("@(REX\['NOTFOUND_ARTICLE_ID'\].?\=.?)[^;]*@", '${1}'.strtolower($neu_notfoundartikel), $cont);
    $REX['NOTFOUND_ARTICLE_ID'] = $neu_notfoundartikel;
  }

  $sql = rex_sql::factory();
  $sql->setQuery('SELECT * FROM '. $REX['TABLE_PREFIX'] .'template WHERE id='. $neu_defaulttemplateid .' AND active=1');
  if($sql->getRows() != 1 && $neu_defaulttemplateid != 0)
  {
    $warning .= $I18N->msg('settings_invalid_default_template')."<br />";
  }else
  {
    $cont = preg_replace("@(REX\['DEFAULT_TEMPLATE_ID'\].?\=.?)[^;]*@", '${1}'.strtolower($neu_defaulttemplateid), $cont);
    $REX['DEFAULT_TEMPLATE_ID'] = $neu_defaulttemplateid;
  }

  $search = array('\\"', "'", '$');
  $destroy = array('"', "\\'", '\\$');
  $replace = array(
    'search' => array(
      "@(REX\['ERROR_EMAIL'\].?\=.?).*$@m",
      "@(REX\['LANG'\].?\=.?).*$@m",
      "@(REX\['SERVER'\].?\=.?).*$@m",
      "@(REX\['SERVERNAME'\].?\=.?).*$@m",
      "@(REX\['MOD_REWRITE'\].?\=.?).*$@m",
      "@(REX\['SESSION_DURATION'\].?\=.?)[^;]*@",
      "@(REX\['USE_GZIP'\].?\=.?).*$@m",
      "@(REX\['USE_ETAG'\].?\=.?).*$@m",
      "@(REX\['USE_LAST_MODIFIED'\].?\=.?).*$@m",
      "@(REX\['USE_MD5'\].?\=.?).*$@m",
    ),
    'replace' => array(
      "$1'".str_replace($search, $destroy, strtolower($neu_error_emailaddress))."';",
      "$1'".str_replace($search, $destroy, $neu_lang)."';",
      "$1'".str_replace($search, $destroy, $neu_SERVER)."';",
      "$1'".str_replace($search, $destroy, $neu_SERVERNAME)."';",
      '$1'.strtolower(str_replace($search, $destroy, $neu_modrewrite)).';',
      '${1}'.$neu_session_duration,
      "$1'".str_replace($search, $destroy, $neu_use_gzip)."';",
      "$1'".str_replace($search, $destroy, $neu_use_etag)."';",
      "$1'".str_replace($search, $destroy, $neu_use_last_modified)."';",
      "$1'".str_replace($search, $destroy, $neu_use_md5)."';",
    )
  );

  $cont = preg_replace($replace['search'], $replace['replace'], $cont);

  if($warning == '')
  {
    if(rex_put_file_contents($master_file, $cont) > 0)
    {
      $info = $I18N->msg('info_updated');

      // Zuweisungen für Wiederanzeige
      $REX['MOD_REWRITE']       = $neu_modrewrite === 'TRUE';
      // FŸr die Wiederanzeige Slashes strippen
      $REX['ERROR_EMAIL']       = stripslashes($neu_error_emailaddress);
      $REX['SERVER']            = stripslashes($neu_SERVER);
      $REX['SERVERNAME']        = stripslashes($neu_SERVERNAME);
      $REX['SESSION_DURATION']  = $neu_session_duration;
      $REX['USE_GZIP']          = $neu_use_gzip;
      $REX['USE_ETAG']          = $neu_use_etag;
      $REX['USE_LAST_MODIFIED'] = $neu_use_last_modified;
      $REX['USE_MD5']           = $neu_use_md5;
    }
  }
}


// CUSTOM ERROR REPORTING
////////////////////////////////////////////////////////////////////////////////
elseif ($func == 'custom_error_reporting')
{
  $master_file = $REX['INCLUDE_PATH'] .'/master.inc.php';
  $cont        = rex_get_file_contents($master_file);
  $settings    = rex_post('error_reporting','array');

  if( rex_post('subfunc','string') == 'reset' ) {
    $cont = preg_replace('/\/\/\sEXTENDED_COREPAGES.*\/\/\s\/EXTENDED_COREPAGES/s','',$cont);
    if(rex_put_file_contents($master_file, $cont) > 0)
    {
      $info = $I18N->msg('info_updated');
    }
    unset($REX["ERROR_REPORTING"]);
  }
  elseif( rex_post('subfunc','string') == 'override' )
  {
    if(preg_match('/\/\/\sEXTENDED_COREPAGES.*\/\/\s\/EXTENDED_COREPAGES/s',$cont) != false)
    {
      // UPDATE
      rex_replace_dynamic_contents($master_file, '$REX["ERROR_REPORTING"] = ' . var_export($settings,true) . ';' );
    }
    else
    {
      // APPEND . '
      $cont .= '
// EXTENDED_COREPAGES
// --- DYN
$REX["ERROR_REPORTING"] = ' . var_export($settings,true) . ';
// --- /DYN

if(!$REX["REDAXO"]){
  ini_set("error_reporting", $REX["ERROR_REPORTING"]["frontend"]["error_reporting"]);
  ini_set("display_errors",  $REX["ERROR_REPORTING"]["frontend"]["display_errors"]);
  ini_set("error_log",       $REX["ERROR_REPORTING"]["frontend"]["error_log"]);
}else{
  ini_set("error_reporting", $REX["ERROR_REPORTING"]["backend"]["error_reporting"]);
  ini_set("display_errors",  $REX["ERROR_REPORTING"]["backend"]["display_errors"]);
  ini_set("error_log",       $REX["ERROR_REPORTING"]["backend"]["error_log"]);
}
// /EXTENDED_COREPAGES
';
      if(rex_put_file_contents($master_file, $cont) > 0)
      {
        $info = $I18N->msg('info_updated');
      }
    }
    $REX["ERROR_REPORTING"] = $settings;
  }
}


// SELECTS
////////////////////////////////////////////////////////////////////////////////
$sel_template = new rex_select();
$sel_template->setStyle('class="rex-form-select"');
$sel_template->setName('neu_defaulttemplateid');
$sel_template->setId('rex-form-default-template-id');
$sel_template->setSize(1);
$sel_template->setSelected($REX['DEFAULT_TEMPLATE_ID']);

$templates = OOCategory::getTemplates(0);
if (empty($templates))
  $sel_template->addOption($I18N->msg('option_no_template'), 0);
else
  $sel_template->addArrayOptions($templates);

$sel_lang = new rex_select();
$sel_lang->setStyle('class="rex-form-select"');
$sel_lang->setName('neu_lang');
$sel_lang->setId('rex-form-lang');
$sel_lang->setSize(1);
$sel_lang->setSelected($REX['LANG']);

foreach ($REX['LOCALES'] as $l)
{
  $sel_lang->addOption($l, $l);
}

$sel_mod_rewrite = new rex_select();
$sel_mod_rewrite->setSize(1);
$sel_mod_rewrite->setStyle('class="rex-form-select"');
$sel_mod_rewrite->setName('neu_modrewrite');
$sel_mod_rewrite->setId('rex-form-mod-rewrite');
$sel_mod_rewrite->setSelected($REX['MOD_REWRITE'] === false ? 'FALSE' : 'TRUE');

$sel_mod_rewrite->addOption('TRUE', 'TRUE');
$sel_mod_rewrite->addOption('FALSE', 'FALSE');



$tmp = new rex_select();
$tmp->setSize(1);
$tmp->setMultiple(false);
$tmp->setStyle('class="rex-form-select"');
$tmp->addOption('false'   , 'false');
$tmp->addOption('true'    , 'true');
$tmp->addOption('frontend', 'frontend');
$tmp->addOption('backend' , 'backend');

$tmp->setName('neu_use_gzip');
$tmp->setId('rex-form-use-gzip');
$tmp->option_selected[0] = $REX['USE_GZIP'];
$sel_use_gzip = $tmp->get();

$tmp->setName('neu_use_etag');
$tmp->setId('rex-form-use-etag');
$tmp->option_selected[0] = $REX['USE_ETAG'];
$sel_use_etag = $tmp->get();

$tmp->setName('neu_use_last_modified');
$tmp->setId('rex-form-use-last_modified');
$tmp->option_selected[0] = $REX['USE_LAST_MODIFIED'];
$sel_use_last_modified = $tmp->get();

$tmp->setName('neu_use_md5');
$tmp->setId('rex-form-use-md5');
$tmp->option_selected[0] = $REX['USE_MD5'];
$sel_use_md5 = $tmp->get();



$tmp = new rex_select();
$tmp->setSize(1);
$tmp->setMultiple(false);
$tmp->setStyle('class="rex-form-select"');
$tmp->addOption('0 '   , '0');
$tmp->addOption('1'    , '1');

$tmp->setName('error_reporting[frontend][display_errors]');
$tmp->setId('rex-form-use-gzip');
$tmp->option_selected[0] = isset($REX['ERROR_REPORTING']['frontend']['display_errors'])
                         ? $REX['ERROR_REPORTING']['frontend']['display_errors']
                         : ini_get('error_reporting');
$sel_frontend_display_error = $tmp->get();

$tmp->setName('error_reporting[backend][display_errors]');
$tmp->setId('rex-form-use-gzip');
$tmp->option_selected[0] = isset($REX['ERROR_REPORTING']['backend']['display_errors'])
                         ? $REX['ERROR_REPORTING']['backend']['display_errors']
                         : ini_get('error_reporting');
$sel_backend_display_error = $tmp->get();


function errorReportingInt2Text($error_reporting)
{
  if((int)$error_reporting != $error_reporting) {
    return $error_reporting;
  }

  $constants = array(
    E_ERROR             => 'E_ERROR',
    E_WARNING           => 'E_WARNING',
    E_PARSE             => 'E_PARSE',
    E_NOTICE            => 'E_NOTICE',
    E_CORE_ERROR        => 'E_CORE_ERROR',
    E_CORE_WARNING      => 'E_CORE_WARNING',
    E_CORE_ERROR        => 'E_COMPILE_ERROR',
    E_CORE_WARNING      => 'E_COMPILE_WARNING',
    E_USER_ERROR        => 'E_USER_ERROR',
    E_USER_WARNING      => 'E_USER_WARNING',
    E_USER_NOTICE       => 'E_USER_NOTICE',
    E_STRICT            => 'E_STRICT',
    E_RECOVERABLE_ERROR => 'E_RECOVERABLE_ERROR',
    E_DEPRECATED        => 'E_DEPRECATED',
    E_USER_DEPRECATED   => 'E_USER_DEPRECATED',
  );
  $types = array();

  for ($i = 0; $i < 15;  $i++ ) {
    $types[] = isset( $constants[ $error_reporting & pow(2, $i) ] )
             ? $constants[ $error_reporting & pow(2, $i) ]
             : 'unknown';
  }

  return count($types)>0 ? '('.implode(', ',$types) . ')' : '';
}


if ($warning != '')
  echo rex_warning($warning);

if ($info != '')
  echo rex_info($info);



// PHPINFO
////////////////////////////////////////////////////////////////////////////////
ob_start();
phpinfo();
$phpinfo = ob_get_contents();
ob_end_clean();
$phpinfo = preg_replace('%^.*<body>(.*)</body>.*$%ms', '$1', $phpinfo);
$phpinfo = str_replace('<h2>Environment</h2>', '<h2><a name="env">Environment</a></h2>', $phpinfo);
$phpinfo = str_replace('<h2>PHP Variables</h2>', '<h2><a name="phpvar">PHP Variables</a></h2>', $phpinfo);
$phpinfo = str_replace('<h2>PHP Core</h2>', '<h2><a name="phpcore">PHP Core</a></h2>', $phpinfo);


echo '<style>'.rex_get_file_contents($myroot . 'assets/specials.css').'</style>';

echo '
  <div class="rex-form" id="rex-form-system-setup">
    <form action="index.php" method="post">
      <input type="hidden" name="page" value="specials" />
      <input type="hidden" name="func" value="updateinfos" />

      <div class="rex-area-col-2">
        <div class="rex-area-col-a">

          <h3 class="rex-hl2">'.$I18N->msg("specials_features").'</h3>

          <div class="rex-area-content">
            <h4 class="rex-hl3">'.$I18N->msg("delete_cache").'</h4>
            <p class="rex-tx1">'.$I18N->msg("delete_cache_description").'</p>
            <p class="rex-button">
              <a class="rex-button" href="index.php?page=specials&amp;func=generate"><span><span>'.$I18N->msg("delete_cache").'</span></span></a>
              <a class="rex-button" href="index.php?page=specials&amp;func=generate_but_images"><span><span>'.$I18N->msg("specials_clear_all_caches_but_images").'</span></span></a>
            </p>

            <h4 class="rex-hl3">'.$I18N->msg("setup").'</h4>
            <p class="rex-tx1">'.$I18N->msg("setup_text").'</p>
            <p class="rex-button"><a class="rex-button" href="index.php?page=specials&amp;func=setup" onclick="return confirm(\''.$I18N->msg("setup").'?\');"><span><span>'.$I18N->msg("setup").'</span></span></a></p>

            <h4 class="rex-hl3">'.$I18N->msg("version").'</h4>
            <p class="rex-tx1">
            REDAXO: '.$REX['VERSION'].'.'.$REX['SUBVERSION'].'.'.$REX['MINORVERSION'];

if(isset($REX['RELEASE'])){
  echo '
            <br />
            RELEASE: <a href="https://github.com/gn2netwerk/redaxo4/commit/'.$REX['RELEASE'].'" target="_blank">'.$REX['RELEASE'].'</a><br />
            ';
}

echo '
            </p>

            <h4 class="rex-hl3">'.$I18N->msg("database").'</h4>
            <p class="rex-tx1">MySQL: '.$REX['MYSQL_VERSION'].'<br />'.$I18N->msg("name").': '.htmlspecialchars($REX['DB']['1']['NAME']).'<br />'.$I18N->msg("host").': '.htmlspecialchars($REX['DB']['1']['HOST']).'</p>

          </div>
        </div>

        <div class="rex-area-col-b">

          <h3 class="rex-hl2">'.$I18N->msg("specials_settings").'</h3>

          <div class="rex-area-content">

            <fieldset class="rex-form-col-1">
              <legend>'.$I18N->msg("general_info_header").'</legend>

              <div class="rex-form-wrapper">

            <!--
              <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-read">
                    <label for="rex-form-version">Version</label>
                    <span class="rex-form-read" id="rex-form-version">'.$REX['VERSION'].'.'.$REX['SUBVERSION'].'.'.$REX['MINORVERSION'].'</span>
                  </p>
                </div>
            -->

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-text">
                    <label for="rex-form-servername" title="'.$I18N->msg("specials_settings_servername").'">$REX[\'SERVERNAME\']</label>
                    <input class="rex-form-text" type="text" id="rex-form-servername" name="neu_SERVERNAME" value="'. htmlspecialchars($REX['SERVERNAME']).'" />
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-text">
                    <label for="rex-form-server" title="'.$I18N->msg("specials_settings_server").'">$REX[\'SERVER\']</label>
                    <input class="rex-form-text" type="text" id="rex-form-server" name="neu_SERVER" value="'. htmlspecialchars($REX['SERVER']).'" />
                  </p>
                </div>
              </div>
            <!--
            </fieldset>
            -->

            <!--
            <fieldset class="rex-form-col-1">
              <legend>'.$I18N->msg("db1_can_only_be_changed_by_setup").'</legend>

              <div class="rex-form-wrapper">

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-read">
                    <label for="rex-form-db-host">$REX[\'DB\'][\'1\'][\'HOST\']</label>
                    <span class="rex-form-read" id="rex-form-db-host">&quot;'.htmlspecialchars($REX['DB']['1']['HOST']).'&quot;</span>
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-text">
                    <label for="rex-form-db-login">$REX[\'DB\'][\'1\'][\'LOGIN\']</label>
                    <span id="rex-form-db-login">&quot;'.htmlspecialchars($REX['DB']['1']['LOGIN']).'&quot;</span>
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-read">
                    <label for="rex-form-db-psw">$REX[\'DB\'][\'1\'][\'PSW\']</label>
                    <span class="rex-form-read" id="rex-form-db-psw">&quot;****&quot;</span>
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-read">
                    <label for="rex-form-db-name">$REX[\'DB\'][\'1\'][\'NAME\']</label>
                    <span class="rex-form-read" id="rex-form-db-name">&quot;'.htmlspecialchars($REX['DB']['1']['NAME']).'&quot;</span>
                  </p>
                </div>
              </div>
            </fieldset>
            -->

            <!--
            <fieldset class="rex-form-col-1">
              <legend>'.$I18N->msg("specials_others").'</legend>

              <div class="rex-form-wrapper">
            -->

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-read">
                    <label for="rex_include_path" title="'.$I18N->msg("specials_settings_include_path").'">$REX[\'INCLUDE_PATH\']</label>
                    <span class="rex-form-read" id="rex_include_path" title="'. htmlspecialchars($REX['INCLUDE_PATH']) .'">&quot;';

                    $tmp = $REX['INCLUDE_PATH'];
                    if (strlen($REX['INCLUDE_PATH'])>21)
                      $tmp = substr($tmp,0,8)."..".substr($tmp,strlen($tmp)-13);

                    echo $tmp;

           echo '&quot;</span>
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-text">
                    <label for="rex-form-error-email" title="'.$I18N->msg("specials_settings_error_email").'">$REX[\'ERROR_EMAIL\']</label>
                    <input class="rex-form-text" type="text" id="rex-form-error-email" name="neu_error_emailaddress" value="'.htmlspecialchars($REX['ERROR_EMAIL']).'" />
                  </p>
                </div>

                <div class="rex-form-row">
                  <div class="rex-form-col-a rex-form-widget">
                    <label for="rex-form-startarticle-id" title="'.$I18N->msg("specials_settings_startarticle").'">$REX[\'START_ARTICLE_ID\']</label>
                    '. rex_var_link::_getLinkButton('neu_startartikel', 1, $REX['START_ARTICLE_ID']) .'
                  </div>
                </div>

                <div class="rex-form-row">
                  <div class="rex-form-col-a rex-form-widget">
                    <label for="rex-form-notfound-article-id" title="'.$I18N->msg("specials_settings_notfound_article").'">$REX[\'NOTFOUND_ARTICLE_ID\']</label>
                    '. rex_var_link::_getLinkButton('neu_notfoundartikel', 2, $REX['NOTFOUND_ARTICLE_ID']) .'
                  </div>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-select">
                    <label for="rex-form-default-template-id" title="'.$I18N->msg("specials_settings_default_template").'">$REX[\'DEFAULT_TEMPLATE_ID\']</label>
                    '. $sel_template->get() .'
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-select">
                    <label for="rex-form-lang" title="'.$I18N->msg("specials_settings_backend_lang").'">$REX[\'LANG\']</label>
                    '.$sel_lang->get().'
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-select">
                    <label for="rex-form-mod-rewrite" title="'.$I18N->msg("specials_settings_mod_rewrite").'">$REX[\'MOD_REWRITE\']</label>
                    '.$sel_mod_rewrite->get().'
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-text">
                    <label for="rex-form-session-duration" title="">$REX[\'SESSION_DURATION\']</label>
                    <input class="rex-form-text" type="text" id="rex-form-session-duration" name="neu_session_duration" value="'. htmlspecialchars($REX['SESSION_DURATION']).'" />
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-select">
                    <label for="rex-form-use-gzip" title="">$REX[\'USE_GZIP\']</label>
                    '. $sel_use_gzip .'
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-select">
                    <label for="rex-form-use-etag" title="">$REX[\'USE_ETAG\']</label>
                    '. $sel_use_etag .'
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-select">
                    <label for="rex-form-use-last_modified" title="">$REX[\'USE_LAST_MODIFIED\']</label>
                    '. $sel_use_last_modified .'
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-select">
                    <label for="rex-form-use-md5" title="">$REX[\'USE_MD5\']</label>
                    '. $sel_use_md5 .'
                  </p>
                </div>

                <div class="rex-form-row">
                  <p class="rex-form-col-a rex-form-submit">
                    <input type="submit" class="rex-form-submit" name="sendit" value="'.$I18N->msg("specials_update").'"'. rex_accesskey($I18N->msg('specials_update'), $REX['ACKEY']['SAVE']) .' />
                  </p>
                </div>

            <!--
                </div>
            -->

            </fieldset>

          </div> <!-- Ende rex-area-content //-->

        </div> <!-- Ende rex-area-col-b //-->

      </div> <!-- Ende rex-area-col-2 //-->

    </form>






<div class="rex-clearer"></div>

<div class="rex-area-col-2">

  <div class="rex-area-col-a">

    <h2 class="rex-hl2">Server Info <span style="font-size:12px;font-weight:normal;"> [ <a href="#phpinfo" class="trigger" data-target="#phpinfo-wrapper" data-func="toggle">phpinfo()</a> ]</span></h2>

    <div class="rex-area-content">

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>PHP Version:</label>
          <span class="rex-form-read">'.phpversion().'</span>
        </p>
        <br />
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>max_execution_time:</label>
          <span class="rex-form-read">'.ini_get('max_execution_time').'</span>
        </p>
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>max_input_time:</label>
          <span class="rex-form-read">'.ini_get('max_input_time').'</span>
        </p>
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>memory_limit:</label>
          <span class="rex-form-read">'.ini_get('memory_limit').'</span>
        </p>
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>post_max_size:</label>
          <span class="rex-form-read">'.ini_get('post_max_size').'</span>
        </p>
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>upload_max_filesize:</label>
          <span class="rex-form-read">'.ini_get('upload_max_filesize').'</span>
        </p>
        <br />
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>allow_url_fopen:</label>
          <span class="rex-form-read">' . (ini_get('allow_url_fopen') == 0 ? '0' : '1') . '</span>
        </p>
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>curl_exec():</label>
          <span class="rex-form-read">' . (function_exists('curl_exec') == 0 ? '0' : '1') . '</span>
        </p>
        <br />
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>exec():</label>
          <span class="rex-form-read">' . (function_exists('exec') == 0 ? '0' : '1') . '</span>
        </p>
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>system():</label>
          <span class="rex-form-read">' . (function_exists('system') == 0 ? '0' : '1') . '</span>
        </p>
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>passthru():</label>
          <span class="rex-form-read">' . (function_exists('passthru') == 0 ? '0' : '1') . '</span>
        </p>
        <br />
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>register_globals:</label>
          <span class="rex-form-read">' . (ini_get('register_globals') == 0 ? '0' : '1') . '</span>
        </p>
      </div>

      <div class="rex-form-row form-row-compact">
        <p class="rex-form-col-a rex-form-read">
          <label>
            safe_mode:
          </label>
          <span class="rex-form-read">
            ' . (ini_get('safe_mode') == 0 ? '0' : '1') . '
          </span>
        </p>
      </div>

      <div class="rex-clearer"></div>

    </div>
  </div>
';
?>


  <div class="rex-area-col-b">

    <h2 class="rex-hl2">Error Reporting
      <span style="font-weight:normal;font-size:12px;"> [
        <a href="#error_reporting" class="trigger" data-target="#custom_error_reporting, #default_error_reporting" data-func="toggle">
          custom override
        </a>]
      </span>
    </h2>

    <div class="rex-area-content">

      <div id="default_error_reporting" style="display:<?php echo isset($REX['ERROR_REPORTING']) ? 'none' : 'block' ?>;">

        <div class="rex-form-row form-row-compact">
          <p class="rex-form-col-a rex-form-read">
            <label>display_errors:</label>
            <span class="rex-form-read"><?php echo ini_get('display_errors') == 0 ? '0' : '1'?></span>
          </p>
        </div>

        <div class="rex-form-row form-row-compact">
          <p class="rex-form-col-a rex-form-read">
            <label>error_log:</label>
            <span class="rex-form-read">
              <?php echo ini_get('error_log')?>
            </span>
          </p>
        </div>

        <div class="rex-form-row form-row-compact" style="display:table">
          <p class="rex-form-col-a rex-form-read" style="display:table-row">
            <label style="display:table-cell">error_reporting:</label>
            <span class="rex-form-read" style="display:table-cell;float:none;">
              <?php echo error_reporting()?>
              <code>
                <?php echo errorReportingInt2Text(error_reporting())?>
              </code>
            </span>
          </p>
        </div>

      </div><!-- /#default_error_reporting -->



      <div class="rex-clearer"></div>



      <div id="custom_error_reporting" style="display:<?php echo isset($REX['ERROR_REPORTING']) ? 'block' : 'none' ?>;">

        <form action="index.php" method="post">
          <input type="hidden" name="page" value="specials" />
          <input type="hidden" name="func" value="custom_error_reporting" />

          <fieldset class="rex-form-col-1">

            <legend>Frontend</legend>

            <div class="rex-form-wrapper">

              <div class="rex-form-row">
                <p class="rex-form-col-a rex-form-text">
                  <label>error_reporting</label>
                  <input class="rex-form-text" type="text" id="" name="error_reporting[frontend][error_reporting]" value="<?php echo isset($REX['ERROR_REPORTING']['frontend']['error_reporting']) ? $REX['ERROR_REPORTING']['frontend']['error_reporting'] : error_reporting()?>" />
                </p>
              </div>

              <div class="rex-form-row">
                <p class="rex-form-col-a rex-form-select">
                  <label>display_error</label>
                  <?php echo $sel_frontend_display_error ?>
                </p>
              </div>

              <div class="rex-form-row">
                <p class="rex-form-col-a rex-form-text">
                  <label>error_log</label>
                  <input class="rex-form-text" type="text" id="" name="error_reporting[frontend][error_log]" value="<?php echo isset($REX['ERROR_REPORTING']['frontend']['error_log']) ? $REX['ERROR_REPORTING']['frontend']['error_log'] : ini_get('error_log')?>" />
                </p>
              </div>



            </div>

          </fieldset>

          <fieldset class="rex-form-col-1">

            <legend>Backend</legend>

            <div class="rex-form-wrapper">

              <div class="rex-form-row">
                <p class="rex-form-col-a rex-form-text">
                  <label>error_reporting</label>
                  <input class="rex-form-text" type="text" id="rex-form-error-email" name="error_reporting[backend][error_reporting]" value="<?php echo isset($REX['ERROR_REPORTING']['backend']['error_reporting']) ? $REX['ERROR_REPORTING']['backend']['error_reporting'] : error_reporting()?>" />
                </p>
              </div>

              <div class="rex-form-row">
                <p class="rex-form-col-a rex-form-select">
                  <label for="rex-form-use-md5" title="">display_error</label>
                  <?php echo $sel_backend_display_error ?>
                </p>
              </div>

              <div class="rex-form-row">
                <p class="rex-form-col-a rex-form-text">
                  <label>error_log</label>
                  <input class="rex-form-text" type="text" id="rex-form-error-email" name="error_reporting[backend][error_log]" value="<?php echo isset($REX['ERROR_REPORTING']['backend']['error_log']) ? $REX['ERROR_REPORTING']['backend']['error_log'] : ini_get('error_log')?>" />
                </p>
              </div>

              <div class="rex-form-row">
                <p class="rex-form-col-a rex-form-submit">
                  <input type="submit" style="margin-left:0;"class="rex-form-submit" name="subfunc" value="reset" <?php echo rex_accesskey($I18N->msg('form_reset'), $REX['ACKEY']['SAVE'])?> />
                  <input type="submit" style="margin-left:4px;"class="rex-form-submit" name="subfunc" value="override" <?php echo rex_accesskey($I18N->msg('form_save'), $REX['ACKEY']['SAVE'])?> />
                </p>
              </div>

            </div>

          </fieldset>

        </form>


      </div><!-- /#custom_error_reporting -->


      <div class="rex-clearer"></div>

    </div>

  </div><!-- /.rex-area-col-b -->

</div>



<div class="rex-clearer"></div>

<div id="phpinfo-wrapper" style="display:none;">

  <h3 class="rex-hl2" style="font-size:12px;font-weight:normal;line-height:14px;" id="phpinfo-anchors"></h3>

  <div id="phpinfo">
    <?php echo $phpinfo;?>
  </div><!-- /#phpinfo -->

</div><!-- /#phpinfo-wrapper -->

</div><!-- /#rex-form-system-setup -->


<?php echo '<script>'.rex_get_file_contents($myroot . 'assets/specials.js').'</script>'; ?>
