<?php
/**
 * extended_corepages - Redaxo be_style Plugin
 *
 * @version 1.3.2
 * @package redaxo 4.4.x/4.5.x
 */

if(!$REX['REDAXO'] || !isset($REX['USER'])){
  return;
}

$mypage   = 'extended_corepages';
$myparent = implode(array_slice(explode(DIRECTORY_SEPARATOR,__FILE__), -4, 1));
$myroot   = $REX['INCLUDE_PATH'].'/addons/'.$myparent.'/plugins/'.$mypage;


// PAGES
////////////////////////////////////////////////////////////////////////////////
$REX["PAGES"]['addon']->page->path     = $myroot.'/pages/addon.inc.php';
$REX["PAGES"]['specials']->page->path  = $myroot.'/pages/specials.inc.php';
$REX["PAGES"]['mediapool']->page->path = $myroot.'/pages/mediapool.inc.php';


$REX['ADDON']['version'][$mypage]     = '1.3.2';
$REX['ADDON']['author'][$mypage]      = 'jdlx';
$REX['ADDON']['supportpage'][$mypage] = 'forum.redaxo.de';

$REX['ADDON']['page'][$mypage]        = $mypage;
$REX['ADDON']['title'][$mypage]       = 'Extended Corepages';
$REX['ADDON']['perm'][$mypage]        = 'admin[]';



// SETTINGS
////////////////////////////////////////////////////////////////////////////////
// --- DYN
$REX["extended_corepages"]["settings"] = array ();
// --- /DYN
