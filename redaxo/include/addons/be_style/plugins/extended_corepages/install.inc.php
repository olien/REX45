<?php
/**
 * extended_corepages - Redaxo be_style Plugin
 *
 * @version 1.3.2
 * @package redaxo 4.4.x/4.5.x
 */

$myself      = 'extended_corepages';
$minimum_REX = '4.5.0';
$minimum_PHP = 5.3;


// CHECK REDAXO VERSION
////////////////////////////////////////////////////////////////////////////////
if(version_compare($REX['VERSION'].'.'.$REX['SUBVERSION'].'.'.$REX['MINORVERSION'], $minimum_REX, '<'))
{
  $REX['ADDON']['installmsg'][$myself] = 'Requires Redaxo '.$minimum_REX.' or higher.';
  $REX['ADDON']['install'][$myself]    = 0;
  return;
}


// CHECK PHP VERSION
////////////////////////////////////////////////////////////////////////////////
if(version_compare(PHP_VERSION, $minimum_PHP, '<'))
{
  $REX['ADDON']['installmsg'][$myself] = 'Requires PHP '.$minimum_PHP.' or higher.';
  $REX['ADDON']['install'][$myself]    = 0;
  return;
}

$REX['ADDON']['install'][$myself] = 1;
