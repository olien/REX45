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

// -------------- Defaults

$subpage = rex_request('subpage', 'string');
$func    = rex_request('func', 'string');

// -------------- Header

rex_title($I18N->msg('specials').' <span style="color:silver;font-size:0.4em;">'.$myparent.'::'.$mypage.' '.$REX['ADDON']['plugins'][$myparent]['version'][$mypage].'</span>', $REX['PAGES']['specials']->getPage()->getSubPages());

$content = rex_register_extension_point('PAGE_SPECIALS_OUTPUT', "",
  array(
    'subpage' => $subpage,
  )
);

if($content != "") {
  echo $content;

} else {
  switch($subpage) {
    case 'lang': $file = 'specials.clangs.inc.php'; break;
    default : $file = 'specials.settings.inc.php'; break;
  }

  require $myroot.'pages/'.$file;

}

require $REX['INCLUDE_PATH'] . '/layout/bottom.php';
