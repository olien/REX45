## Redaxo Database Dump Version 4
## Prefix rex_
## charset utf-8

DROP TABLE IF EXISTS `rex_135_imagecropper_config`;
CREATE TABLE `rex_135_imagecropper_config` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `preset1` varchar(9) NOT NULL DEFAULT '50x33',
  `preset2` varchar(9) NOT NULL DEFAULT '100x67',
  `preset3` varchar(9) NOT NULL DEFAULT '150x100',
  `preset4` varchar(9) NOT NULL DEFAULT '200x133',
  `preset5` varchar(9) NOT NULL DEFAULT '400x267',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Addon ImageCropper Konfiguration';

LOCK TABLES `rex_135_imagecropper_config` WRITE;
/*!40000 ALTER TABLE `rex_135_imagecropper_config` DISABLE KEYS */;
INSERT INTO `rex_135_imagecropper_config` VALUES 
  (1,'50x33','100x67','150x100','200x133','400x267');
/*!40000 ALTER TABLE `rex_135_imagecropper_config` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_420_xoutputfilter`;
CREATE TABLE `rex_420_xoutputfilter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `typ` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `lang` int(11) NOT NULL DEFAULT '0',
  `marker` text NOT NULL,
  `html` text NOT NULL,
  `allcats` tinyint(1) NOT NULL DEFAULT '0',
  `subcats` tinyint(1) NOT NULL DEFAULT '0',
  `once` tinyint(1) NOT NULL DEFAULT '0',
  `categories` text NOT NULL,
  `insertbefore` tinyint(1) NOT NULL DEFAULT '0',
  `excludeids` text NOT NULL,
  `useragent` text NOT NULL,
  `dataarea` text NOT NULL,
  `validfrom` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `validto` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_420_xoutputfilter` WRITE;
/*!40000 ALTER TABLE `rex_420_xoutputfilter` DISABLE KEYS */;
INSERT INTO `rex_420_xoutputfilter` VALUES 
  (1,4,1,'Beispiel_003','Alle HTML-Kommentare entfernen - ausser Conditional Comments für IE',0,'/<!--[^\\[](.|\\s)*?[^\\]]-->/','',1,1,0,'',3,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (2,4,1,'Beispiel_005','Ungeschlossene Tags schliessen (<br>, <hr>, <img>, <input>, <meta>, <base>, <basefont>, <param>, <link>, <area>)',0,'/\r\n<(br|hr|img|input|meta|base|basefont|param|link|area)\r\n+\r\n((\\s+[a-zA-Z-]+\\s*=\\s*(\"([^\"]*)\"|\'([^\']*)\'|([a-zA-Z0-9]*)))*\\s*)>\r\n/ix','<$1$2 />',1,1,0,'',3,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (3,4,0,'Beispiel_006','Leere HTML-Tags entfernen (<p>, <span>, <strong>, <b>, <em>, <h1>, <h2>, <h3>, <h4>, <h5>, <h6>)',0,'/<(p|span|strong|b|em|h1|h2|h3|h4|h5|h6)>(\\s|\\b)*<\\/\\1>/','',1,1,0,'',3,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (4,4,1,'Beispiel_007','Fehlende alt-Attribute bei <img>-Tags einfügen',0,'/(?!<img[^>]*\\salt[^=>]*=[^>]*>)<img[^>](.*)(>)/','<img alt=\"\" $1>',1,1,0,'',3,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (5,4,1,'Beispiel_008','Zeichen und Tags ersetzen / entfernen',0,'<head>','<?php\r\n/**\r\n * Zeichen und Tags ersetzen / entfernen\r\n */\r\nglobal $REX;\r\n\r\n  $xoutputfilter_codereplace = array(\r\n  \'<b>\' => \'<strong>\' ,\r\n  \'</b>\' => \'</strong>\' ,\r\n  \'<i>\' => \'<em>\' ,\r\n  \'</i>\' => \'</em>\' ,\r\n  \'ä\' => \'&auml;\' ,\r\n  \'ö\' => \'&ouml;\' ,\r\n  \'ü\' => \'&uuml;\' ,\r\n  \'Ä\' => \'&Auml;\' ,\r\n  \'Ö\' => \'&Ouml;\' ,\r\n  \'Ü\' => \'&Uuml;\' ,\r\n  \'ß\' => \'&szlig;\',\r\n  \'(c)\' => \'&copy;\',\r\n  \' ismap=\"ismap\"\' => \'\',\r\n  \' ismap=\"true\"\' => \'\',\r\n  \' target=\"_self\"\' => \'\',\r\n  \' target=\"_blank\"\' => \' onclick=\"window.open(this.href); return false;\"\',\r\n  \'<div align=\"center\">\' => \'<div style=\"text-align:center;\">\',\r\n  \'<hr width=\"100%\" size=\"2\" />\' => \'<hr />\'\r\n  );\r\n\r\n  $search = array();\r\n  $replace = array();\r\n  foreach ($xoutputfilter_codereplace as $key => $value)\r\n  {\r\n    $search[] = $key;\r\n    $replace[] = $value;\r\n  }\r\n  $REX[\'xoutputfilter\'][\'content\'] = str_replace($search, $replace, $REX[\'xoutputfilter\'][\'content\']);\r\n?>',1,1,1,'',4,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (6,4,1,'Beispiel_010','E-Mail-Adressen mit Klasse email versehen und verschlüsseln',0,'mailto:','<?php\r\n/**\r\n * E-Mail Adressen verschlüsseln\r\n */\r\nglobal $REX;\r\n\r\n  // hier via regEx alle absoluten, externen Linkadressen heraussuchen\r\n  preg_match_all(\"/<a[^>]*(href\\s*=\\s*(\\\"|\')(mailto)(?=:).*?(\\\"|\'))[^>]*>(.*?)<\\/a>/ims\", $REX[\'xoutputfilter\'][\'content\'], $matches);\r\n\r\n  // hier jetzt alle gefundenen durchgehen und um klasse erweitern\r\n  if ( isset ($matches[0][0]) and $matches[0][0] != \'\')\r\n  {\r\n    for ($m = 0; $m < count ($matches[0]); $m++)\r\n    {\r\n      $msearch = $matches[0][$m];\r\n      if (strstr($matches[0][$m], \'class=\'))\r\n      {\r\n        $mreplace = $matches[0][$m];\r\n      }\r\n      else\r\n      {\r\n        $mreplace = str_replace(\'href=\', \'class=\"email\" href=\', $matches[0][$m]);\r\n      }\r\n      $REX[\'xoutputfilter\'][\'content\'] = str_replace($msearch, $mreplace, $REX[\'xoutputfilter\'][\'content\']);\r\n    }\r\n  }\r\n\r\n  // hier jetzt alle gefundenen durchgehen und crypt\r\n  if ( isset ($matches[1][0]) and $matches[1][0] != \'\')\r\n  {\r\n    for ($m = 0; $m < count ($matches[1]); $m++)\r\n    {\r\n      $va = explode(\'mailto:\', $matches[1][$m]);\r\n      $originalemail = str_replace(\'\"\', \'\', $va[1]);\r\n\r\n      $encryptedemail = \'\';\r\n      for ($i=0; $i < strlen($originalemail); $i++) {\r\n        $encryptedemail .= \'&#\'.ord(substr($originalemail, $i, 1)).\';\';\r\n      }\r\n\r\n      $msearch = \'mailto:\'.$originalemail;\r\n      $mreplace = \'mailto:\'.str_replace(\'&#64;\', \'%40\', $encryptedemail);\r\n      $REX[\'xoutputfilter\'][\'content\'] = str_replace($msearch, $mreplace, $REX[\'xoutputfilter\'][\'content\']);\r\n\r\n      $msearch = $originalemail;\r\n      $mreplace = $encryptedemail;\r\n      $REX[\'xoutputfilter\'][\'content\'] = str_replace($msearch, $mreplace, $REX[\'xoutputfilter\'][\'content\']);\r\n    }\r\n  }\r\n?>',1,1,1,'',4,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (7,4,1,'Beispiel_012','Externe Links mit Klasse extern versehen',0,'href=\"http:','<?php\r\n/**\r\n * Kennzeichnung externe Links mit Ausnahme\r\n */\r\nglobal $REX;\r\n\r\n  //$content = $REX[\'xoutputfilter\'][\'content\'];\r\n\r\n  // Von der Ersetzung ausgeschlossen:\r\n  $excl = array();\r\n  $excl[] = \'href=\"\' . $REX[\'SERVER\'];\r\n  $excl[] = \'href=\"http://\' . $_SERVER[\'HTTP_HOST\'];\r\n  $excl[] = \'href=\"https://\' . $_SERVER[\'HTTP_HOST\'];\r\n  $excl[] = \'#top\';\r\n  $excl[] = \'#nav\';\r\n  $excl[] = \'#mainnav\';\r\n  $excl[] = \'#hauptnavigation\';\r\n  $excl[] = \'#content\';\r\n  $excl[] = \'href=\"http://www.facebook.com/\';\r\n  $excl[] = \'href=\"http://twitter.com/\';\r\n\r\n  // hier via regEx alle absoluten, externen Linkadressen heraussuchen\r\n  preg_match_all(\"/<a[^>]*(href\\s*=\\s*(\\\"|\')(http(s)?|ftp(s)?|telnet|irc)(?=:\\/\\/).*?(\\\"|\'))[^>]*>(.*?)<\\/a>/ims\", $REX[\'xoutputfilter\'][\'content\'], $matches);\r\n\r\n  if ( isset ($matches[0][0]) and $matches[0][0] != \'\')\r\n  {\r\n    $srch = $repl = array();\r\n    for ($m = 0; $m < count ($matches[0]); $m++)\r\n    {\r\n      $msearch = $matches[0][$m];\r\n      if (strstr($matches[0][$m], \'class=\'))\r\n      {\r\n        $mreplace = $matches[0][$m];\r\n      }\r\n      else\r\n      {\r\n        $mreplace = str_replace(\'href=\', \'class=\"extern\" href=\', $matches[0][$m]);\r\n      }\r\n      for ($x = 0; $x < count($excl); $x++)\r\n      {\r\n        if (strstr($matches[1][$m], $excl[$x]))\r\n        {\r\n          $mreplace = $matches[0][$m];\r\n        }\r\n      }\r\n      $srch[] = $msearch;\r\n      $repl[] = $mreplace;\r\n    }\r\n    $REX[\'xoutputfilter\'][\'content\'] = str_replace($srch, $repl, $REX[\'xoutputfilter\'][\'content\']);\r\n  }  \r\n?>',1,1,1,'',4,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (8,4,0,'Beispiel_013','Wartungsarbeiten - Nicht angemeldete Benutzer auf eine Wartungsseite umleiten',0,'<head>','<?php\r\n/**\r\n* Wartungsarbeiten\r\n*/\r\n  global $REX;\r\n\r\n  // Hier die URL angeben auf die weitergeleitet werden soll!\r\n  $offline_url = $REX[\'SERVER\'] . \'wartungsarbeiten.html\';\r\n\r\n  // evtl. Weiterleitung\r\n  @session_start();\r\n  $islogon = false;\r\n  \r\n  if (isset($_SESSION[$REX[\'INSTNAME\']]) and isset($_SESSION[$REX[\'INSTNAME\']][\'UID\']) and $_SESSION[$REX[\'INSTNAME\']][\'UID\']<>\'\')\r\n  {\r\n    $islogon = true;\r\n  }\r\n\r\n  if (!$islogon) \r\n  {\r\n    if ( !strstr($_SERVER[\"REQUEST_URI\"], \'&maintenance\') )\r\n    {\r\n      $trash = ob_get_contents();\r\n      ob_end_clean();\r\n      if (strstr($offline_url, \'?\'))\r\n      {\r\n        header(\'Location: \' . $offline_url . \'&maintenance\');\r\n      }\r\n      else\r\n      {\r\n        header(\'Location: \' . $offline_url);\r\n      }\r\n      \r\n    }\r\n  }\r\n?>',1,1,1,'',4,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (9,5,0,'Beispiel_001','Beispiel für HTML-Insert im Header (mit PHP-Code)',0,'<head>',' \r\n\r\n<!--\r\n	Beispiel für einen Insert im Header-Bereich des Backends ;-)\r\n<?php\r\n	global $REX;\r\n	echo date(\'	d.m.Y H:i:s\') . \"\\n\";\r\n	echo \'	REDAXO Version: \' . $REX[\'VERSION\'] . \'.\' . $REX[\'SUBVERSION\'] . \'.\' . $REX[\'MINORVERSION\'] . \"\\n\";\r\n?>\r\n-->\r\n\r\n',1,0,1,'',0,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (10,5,1,'Beispiel_002','Anzeige der REDAXO-Version im Backend',0,'<li class=\"rex-navi-first\">','<?php\r\n  global $REX;\r\n  echo \'<em>Version: \'\r\n    . $REX[\'VERSION\'] . \'.\' . $REX[\'SUBVERSION\'] . \'.\' . $REX[\'MINORVERSION\']\r\n    . \'</em>&nbsp;&nbsp;</li><li>\';\r\n?>',1,0,1,'',0,'mediapool','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (11,5,1,'Beispiel_003','Link zum Frontend einfügen',0,'<li><a href=\"index.php?page=profile\">Mein Profil</a></li>','<li>\r\n<a href=\"../index.php\" onclick=\"window.open(this.href); return false;\">zur Webseite</a>\r\n</li>',1,0,1,'',1,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (12,5,1,'Beispiel_004','Beispiel \"abmelden\" durch \"Logout\" ersetzen',0,'<a href=\"index.php?rex_logout=1\" title=\"abmelden\">abmelden</a>\r\n|\r\n<a href=\"index.php?rex_logout=1\" accesskey=\"l\" title=\"abmelden [l]\">abmelden</a>','<a href=\"index.php?rex_logout=1\" accesskey=\"l\" title=\"Logout [l]\">Logout</a>',1,0,1,'',2,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (13,5,1,'Beispiel_005','Beispiel Linkmap und Medienpool ohne REDAXO-Logo (4.3.x)',0,'</head>\r\n<body class=\"rex-popuplinkmap\r\n|\r\n</head>\r\n<body class=\"rex-popupmediapool','  \r\n<style type=\"text/css\">\r\n#rex-website { margin-top:-65px; }\r\n#rex-wrapper { margin-top:-50px; } \r\n</style>\r\n ',0,0,1,'linkmap, mediapool',1,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (14,5,1,'Beispiel_006','Beispiel Linkmap und Medienpool ohne REDAXO-Logo (4.2.x)',0,'</head>\r\n<body id=\"rex-popup\r\n|','  \r\n<style type=\"text/css\">\r\n#rex-website { margin-top:-65px; }\r\n#rex-wrapper { margin-top:-20px; } \r\n</style>\r\n ',0,0,1,'linkmap, mediapool',1,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00'),
  (15,5,0,'Beispiel_007','Alle HTML-Kommentare entfernen - ausser Conditional Comments für IE',0,'/<!--[^\\[](.|\\s)*?[^\\]]-->/','',1,0,0,'',3,'','','','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `rex_420_xoutputfilter` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_587_keywords`;
CREATE TABLE `rex_587_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL,
  `soundex` varchar(255) NOT NULL,
  `metaphone` varchar(255) NOT NULL,
  `colognephone` varchar(255) NOT NULL,
  `clang` int(11) NOT NULL DEFAULT '-1',
  `count` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyword` (`keyword`,`clang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_587_searchcache`;
CREATE TABLE `rex_587_searchcache` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` char(32) NOT NULL,
  `returnarray` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_587_searchcacheindex_ids`;
CREATE TABLE `rex_587_searchcacheindex_ids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `index_id` int(11) DEFAULT NULL,
  `cache_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_587_searchindex`;
CREATE TABLE `rex_587_searchindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` varchar(255) DEFAULT NULL,
  `catid` int(11) DEFAULT NULL,
  `ftable` varchar(255) DEFAULT NULL,
  `fcolumn` varchar(255) DEFAULT NULL,
  `texttype` varchar(255) NOT NULL,
  `clang` int(11) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `fileext` varchar(255) DEFAULT NULL,
  `plaintext` longtext NOT NULL,
  `unchangedtext` longtext NOT NULL,
  `teaser` longtext NOT NULL,
  `values` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`),
  FULLTEXT KEY `plaintext` (`plaintext`),
  FULLTEXT KEY `unchangedtext` (`unchangedtext`),
  FULLTEXT KEY `plaintext_2` (`plaintext`,`unchangedtext`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_62_params`;
CREATE TABLE `rex_62_params` (
  `field_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `prior` int(10) unsigned NOT NULL,
  `attributes` text NOT NULL,
  `type` int(10) unsigned DEFAULT NULL,
  `default` varchar(255) NOT NULL,
  `params` text,
  `validate` text,
  `restrictions` text NOT NULL,
  `createuser` varchar(255) NOT NULL,
  `createdate` int(11) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `updatedate` int(11) NOT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_62_params` WRITE;
/*!40000 ALTER TABLE `rex_62_params` DISABLE KEYS */;
INSERT INTO `rex_62_params` VALUES 
  (1,'translate:pool_file_description','med_description',1,'',2,'','','','','%USER%',1365071511,'%USER%',1365071511),
  (2,'translate:pool_file_copyright','med_copyright',2,'',1,'','','','','%USER%',1365071511,'%USER%',1365071511),
  (3,'translate:online_from','art_online_from',1,'',10,'','','','','%USER%',1365071511,'%USER%',1365071511),
  (4,'translate:online_to','art_online_to',2,'',10,'','','','','%USER%',1365071511,'%USER%',1365071511),
  (5,'translate:description','art_description',3,'',2,'','','','','%USER%',1365071511,'%USER%',1365071511),
  (7,'translate:metadata_image','art_file',5,'',6,'','','','','%USER%',1365071511,'%USER%',1365071511),
  (8,'translate:teaser','art_teaser',6,'',5,'','','','','%USER%',1365071511,'%USER%',1365071511),
  (9,'translate:header_article_type','art_type_id',7,'size=1',3,'','Standard|Zugriff fuer alle','','','%USER%',1365071511,'%USER%',1365071511),
  (18,'translate:keywords','art_keywords',4,'',2,'','','','','olien',1383738748,'olien',1383738748),
  (45,'RexSEO Rewrite','art_rexseo_legend',8,'',12,'','','','','olien',1383743582,'olien',1383743582),
  (46,'Custom URL','art_rexseo_url',9,'',1,'','','','','olien',1383743582,'olien',1383743582),
  (47,'Custom Canonical URL','art_rexseo_canonicalurl',10,'',1,'','','','','olien',1383743583,'olien',1383743583),
  (48,'Custom Page Title','art_rexseo_title',11,'',1,'','','','','olien',1383743583,'olien',1383743583),
  (49,'RexSEO Sitemap','art_rexseo_sitemap_legend',12,'',12,'','','','','olien',1383743583,'olien',1383743583),
  (50,'Sitemap Priority','art_rexseo_priority',13,'',3,'',':auto|1.00:1.00|0.80:0.80|0.64:0.64|0.51:0.51|0.33:0.33|0.00:0.00','','','olien',1383743583,'olien',1383743583),
  (51,'Sitemap Changefreq','art_rexseo_changefreq',14,'',3,'',':auto|never:never|yearly:yearly|monthly:monthly|weekly:weekly|daily:daily|hourly:hourly|always:always','','','olien',1383743583,'olien',1383743583),
  (52,'Sitemap Output','art_rexseo_sitemap_out',15,'',3,'',':auto|show:show|hide:hide','','','olien',1383743583,'olien',1383743583);
/*!40000 ALTER TABLE `rex_62_params` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_62_type`;
CREATE TABLE `rex_62_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `dbtype` varchar(255) NOT NULL,
  `dblength` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_62_type` WRITE;
/*!40000 ALTER TABLE `rex_62_type` DISABLE KEYS */;
INSERT INTO `rex_62_type` VALUES 
  (1,'text','text',0),
  (2,'textarea','text',0),
  (3,'select','varchar',255),
  (4,'radio','varchar',255),
  (5,'checkbox','varchar',255),
  (10,'date','text',0),
  (13,'time','text',0),
  (11,'datetime','text',0),
  (12,'legend','text',0),
  (6,'REX_MEDIA_BUTTON','varchar',255),
  (7,'REX_MEDIALIST_BUTTON','text',0),
  (8,'REX_LINK_BUTTON','varchar',255),
  (9,'REX_LINKLIST_BUTTON','text',0);
/*!40000 ALTER TABLE `rex_62_type` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_630_cronjobs`;
CREATE TABLE `rex_630_cronjobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `parameters` text,
  `interval` varchar(255) DEFAULT NULL,
  `nexttime` int(11) DEFAULT '0',
  `environment` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `createdate` int(11) NOT NULL,
  `createuser` varchar(255) NOT NULL,
  `updatedate` int(11) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_630_cronjobs` WRITE;
/*!40000 ALTER TABLE `rex_630_cronjobs` DISABLE KEYS */;
INSERT INTO `rex_630_cronjobs` VALUES 
  (1,'Artikel-Status','rex_cronjob_article_status','','|1|d|',0,'|0|1|',0,1377518345,'olien',1377518345,'olien'),
  (2,'Tabellen-Optimierung','rex_cronjob_optimize_tables','','|1|d|',0,'|0|1|',0,1377518355,'olien',1377518355,'olien');
/*!40000 ALTER TABLE `rex_630_cronjobs` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_679_type_effects`;
CREATE TABLE `rex_679_type_effects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `effect` varchar(255) NOT NULL,
  `parameters` text NOT NULL,
  `prior` int(11) NOT NULL,
  `updatedate` int(11) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `createdate` int(11) NOT NULL,
  `createuser` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_679_type_effects` WRITE;
/*!40000 ALTER TABLE `rex_679_type_effects` DISABLE KEYS */;
INSERT INTO `rex_679_type_effects` VALUES 
  (1,1,'resize','a:6:{s:15:\"rex_effect_crop\";a:5:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:24:\"rex_effect_crop_position\";s:13:\"middle_center\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:5:\"right\";s:28:\"rex_effect_insert_image_vpos\";s:6:\"bottom\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"200\";s:24:\"rex_effect_resize_height\";s:3:\"200\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:11:\"not_enlarge\";}}',1,1365071512,'%USER%',1365071512,'%USER%'),
  (2,2,'resize','a:6:{s:15:\"rex_effect_crop\";a:5:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:24:\"rex_effect_crop_position\";s:13:\"middle_center\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:5:\"right\";s:28:\"rex_effect_insert_image_vpos\";s:6:\"bottom\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"600\";s:24:\"rex_effect_resize_height\";s:3:\"600\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:11:\"not_enlarge\";}}',1,1365071512,'%USER%',1365071512,'%USER%'),
  (3,3,'resize','a:6:{s:15:\"rex_effect_crop\";a:5:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:24:\"rex_effect_crop_position\";s:13:\"middle_center\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:5:\"right\";s:28:\"rex_effect_insert_image_vpos\";s:6:\"bottom\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:2:\"80\";s:24:\"rex_effect_resize_height\";s:2:\"80\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:11:\"not_enlarge\";}}',1,1365071512,'%USER%',1365071512,'%USER%'),
  (4,4,'resize','a:6:{s:15:\"rex_effect_crop\";a:5:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:24:\"rex_effect_crop_position\";s:13:\"middle_center\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:5:\"right\";s:28:\"rex_effect_insert_image_vpos\";s:6:\"bottom\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"246\";s:24:\"rex_effect_resize_height\";s:3:\"246\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:11:\"not_enlarge\";}}',1,1365071512,'%USER%',1365071512,'%USER%'),
  (5,5,'resize','a:6:{s:15:\"rex_effect_crop\";a:5:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:24:\"rex_effect_crop_position\";s:13:\"middle_center\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:5:\"right\";s:28:\"rex_effect_insert_image_vpos\";s:6:\"bottom\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"246\";s:24:\"rex_effect_resize_height\";s:3:\"246\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:11:\"not_enlarge\";}}',1,1365071512,'%USER%',1365071512,'%USER%'),
  (6,6,'resize','a:9:{s:15:\"rex_effect_crop\";a:6:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:20:\"rex_effect_crop_hpos\";s:6:\"center\";s:20:\"rex_effect_crop_vpos\";s:6:\"middle\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:4:\"left\";s:28:\"rex_effect_insert_image_vpos\";s:3:\"top\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_mirror\";a:5:{s:24:\"rex_effect_mirror_height\";s:0:\"\";s:33:\"rex_effect_mirror_set_transparent\";s:7:\"colored\";s:22:\"rex_effect_mirror_bg_r\";s:0:\"\";s:22:\"rex_effect_mirror_bg_g\";s:0:\"\";s:22:\"rex_effect_mirror_bg_b\";s:0:\"\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"500\";s:24:\"rex_effect_resize_height\";s:0:\"\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:7:\"enlarge\";}s:26:\"rex_effect_rounded_corners\";a:4:{s:34:\"rex_effect_rounded_corners_topleft\";s:0:\"\";s:35:\"rex_effect_rounded_corners_topright\";s:0:\"\";s:37:\"rex_effect_rounded_corners_bottomleft\";s:0:\"\";s:38:\"rex_effect_rounded_corners_bottomright\";s:0:\"\";}s:20:\"rex_effect_workspace\";a:8:{s:26:\"rex_effect_workspace_width\";s:0:\"\";s:27:\"rex_effect_workspace_height\";s:0:\"\";s:25:\"rex_effect_workspace_hpos\";s:4:\"left\";s:25:\"rex_effect_workspace_vpos\";s:3:\"top\";s:36:\"rex_effect_workspace_set_transparent\";s:7:\"colored\";s:25:\"rex_effect_workspace_bg_r\";s:0:\"\";s:25:\"rex_effect_workspace_bg_g\";s:0:\"\";s:25:\"rex_effect_workspace_bg_b\";s:0:\"\";}}',1,1377778069,'olien',1377778049,'olien'),
  (7,7,'resize','a:9:{s:15:\"rex_effect_crop\";a:6:{s:21:\"rex_effect_crop_width\";s:3:\"500\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:20:\"rex_effect_crop_hpos\";s:6:\"center\";s:20:\"rex_effect_crop_vpos\";s:6:\"middle\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:4:\"left\";s:28:\"rex_effect_insert_image_vpos\";s:3:\"top\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_mirror\";a:5:{s:24:\"rex_effect_mirror_height\";s:0:\"\";s:33:\"rex_effect_mirror_set_transparent\";s:7:\"colored\";s:22:\"rex_effect_mirror_bg_r\";s:0:\"\";s:22:\"rex_effect_mirror_bg_g\";s:0:\"\";s:22:\"rex_effect_mirror_bg_b\";s:0:\"\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"500\";s:24:\"rex_effect_resize_height\";s:0:\"\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:11:\"not_enlarge\";}s:26:\"rex_effect_rounded_corners\";a:4:{s:34:\"rex_effect_rounded_corners_topleft\";s:0:\"\";s:35:\"rex_effect_rounded_corners_topright\";s:0:\"\";s:37:\"rex_effect_rounded_corners_bottomleft\";s:0:\"\";s:38:\"rex_effect_rounded_corners_bottomright\";s:0:\"\";}s:20:\"rex_effect_workspace\";a:8:{s:26:\"rex_effect_workspace_width\";s:0:\"\";s:27:\"rex_effect_workspace_height\";s:0:\"\";s:25:\"rex_effect_workspace_hpos\";s:4:\"left\";s:25:\"rex_effect_workspace_vpos\";s:3:\"top\";s:36:\"rex_effect_workspace_set_transparent\";s:7:\"colored\";s:25:\"rex_effect_workspace_bg_r\";s:0:\"\";s:25:\"rex_effect_workspace_bg_g\";s:0:\"\";s:25:\"rex_effect_workspace_bg_b\";s:0:\"\";}}',1,1377778110,'olien',1377778105,'olien'),
  (8,8,'resize','a:9:{s:15:\"rex_effect_crop\";a:6:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:20:\"rex_effect_crop_hpos\";s:6:\"center\";s:20:\"rex_effect_crop_vpos\";s:6:\"middle\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:4:\"left\";s:28:\"rex_effect_insert_image_vpos\";s:3:\"top\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_mirror\";a:5:{s:24:\"rex_effect_mirror_height\";s:0:\"\";s:33:\"rex_effect_mirror_set_transparent\";s:7:\"colored\";s:22:\"rex_effect_mirror_bg_r\";s:0:\"\";s:22:\"rex_effect_mirror_bg_g\";s:0:\"\";s:22:\"rex_effect_mirror_bg_b\";s:0:\"\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"250\";s:24:\"rex_effect_resize_height\";s:0:\"\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:7:\"enlarge\";}s:26:\"rex_effect_rounded_corners\";a:4:{s:34:\"rex_effect_rounded_corners_topleft\";s:0:\"\";s:35:\"rex_effect_rounded_corners_topright\";s:0:\"\";s:37:\"rex_effect_rounded_corners_bottomleft\";s:0:\"\";s:38:\"rex_effect_rounded_corners_bottomright\";s:0:\"\";}s:20:\"rex_effect_workspace\";a:8:{s:26:\"rex_effect_workspace_width\";s:0:\"\";s:27:\"rex_effect_workspace_height\";s:0:\"\";s:25:\"rex_effect_workspace_hpos\";s:4:\"left\";s:25:\"rex_effect_workspace_vpos\";s:3:\"top\";s:36:\"rex_effect_workspace_set_transparent\";s:7:\"colored\";s:25:\"rex_effect_workspace_bg_r\";s:0:\"\";s:25:\"rex_effect_workspace_bg_g\";s:0:\"\";s:25:\"rex_effect_workspace_bg_b\";s:0:\"\";}}',1,1377778140,'olien',1377778140,'olien'),
  (9,9,'resize','a:9:{s:15:\"rex_effect_crop\";a:6:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:20:\"rex_effect_crop_hpos\";s:6:\"center\";s:20:\"rex_effect_crop_vpos\";s:6:\"middle\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:4:\"left\";s:28:\"rex_effect_insert_image_vpos\";s:3:\"top\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_mirror\";a:5:{s:24:\"rex_effect_mirror_height\";s:0:\"\";s:33:\"rex_effect_mirror_set_transparent\";s:7:\"colored\";s:22:\"rex_effect_mirror_bg_r\";s:0:\"\";s:22:\"rex_effect_mirror_bg_g\";s:0:\"\";s:22:\"rex_effect_mirror_bg_b\";s:0:\"\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"125\";s:24:\"rex_effect_resize_height\";s:0:\"\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:7:\"enlarge\";}s:26:\"rex_effect_rounded_corners\";a:4:{s:34:\"rex_effect_rounded_corners_topleft\";s:0:\"\";s:35:\"rex_effect_rounded_corners_topright\";s:0:\"\";s:37:\"rex_effect_rounded_corners_bottomleft\";s:0:\"\";s:38:\"rex_effect_rounded_corners_bottomright\";s:0:\"\";}s:20:\"rex_effect_workspace\";a:8:{s:26:\"rex_effect_workspace_width\";s:0:\"\";s:27:\"rex_effect_workspace_height\";s:0:\"\";s:25:\"rex_effect_workspace_hpos\";s:4:\"left\";s:25:\"rex_effect_workspace_vpos\";s:3:\"top\";s:36:\"rex_effect_workspace_set_transparent\";s:7:\"colored\";s:25:\"rex_effect_workspace_bg_r\";s:0:\"\";s:25:\"rex_effect_workspace_bg_g\";s:0:\"\";s:25:\"rex_effect_workspace_bg_b\";s:0:\"\";}}',1,1377778174,'olien',1377778174,'olien'),
  (10,448051,'resize','a:8:{s:15:\"rex_effect_crop\";a:6:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:20:\"rex_effect_crop_hpos\";s:6:\"center\";s:20:\"rex_effect_crop_vpos\";s:6:\"middle\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:4:\"left\";s:28:\"rex_effect_insert_image_vpos\";s:3:\"top\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_mirror\";a:5:{s:24:\"rex_effect_mirror_height\";s:0:\"\";s:33:\"rex_effect_mirror_set_transparent\";s:7:\"colored\";s:22:\"rex_effect_mirror_bg_r\";s:0:\"\";s:22:\"rex_effect_mirror_bg_g\";s:0:\"\";s:22:\"rex_effect_mirror_bg_b\";s:0:\"\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"200\";s:24:\"rex_effect_resize_height\";s:0:\"\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:7:\"enlarge\";}s:20:\"rex_effect_workspace\";a:8:{s:26:\"rex_effect_workspace_width\";s:0:\"\";s:27:\"rex_effect_workspace_height\";s:0:\"\";s:25:\"rex_effect_workspace_hpos\";s:4:\"left\";s:25:\"rex_effect_workspace_vpos\";s:3:\"top\";s:36:\"rex_effect_workspace_set_transparent\";s:7:\"colored\";s:25:\"rex_effect_workspace_bg_r\";s:0:\"\";s:25:\"rex_effect_workspace_bg_g\";s:0:\"\";s:25:\"rex_effect_workspace_bg_b\";s:0:\"\";}}',1,1369425433,'root',1369425135,'root'),
  (11,448052,'resize','a:8:{s:15:\"rex_effect_crop\";a:6:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:20:\"rex_effect_crop_hpos\";s:6:\"center\";s:20:\"rex_effect_crop_vpos\";s:6:\"middle\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:4:\"left\";s:28:\"rex_effect_insert_image_vpos\";s:3:\"top\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_mirror\";a:5:{s:24:\"rex_effect_mirror_height\";s:0:\"\";s:33:\"rex_effect_mirror_set_transparent\";s:7:\"colored\";s:22:\"rex_effect_mirror_bg_r\";s:0:\"\";s:22:\"rex_effect_mirror_bg_g\";s:0:\"\";s:22:\"rex_effect_mirror_bg_b\";s:0:\"\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:3:\"400\";s:24:\"rex_effect_resize_height\";s:0:\"\";s:23:\"rex_effect_resize_style\";s:7:\"maximum\";s:31:\"rex_effect_resize_allow_enlarge\";s:7:\"enlarge\";}s:20:\"rex_effect_workspace\";a:8:{s:26:\"rex_effect_workspace_width\";s:0:\"\";s:27:\"rex_effect_workspace_height\";s:0:\"\";s:25:\"rex_effect_workspace_hpos\";s:4:\"left\";s:25:\"rex_effect_workspace_vpos\";s:3:\"top\";s:36:\"rex_effect_workspace_set_transparent\";s:7:\"colored\";s:25:\"rex_effect_workspace_bg_r\";s:0:\"\";s:25:\"rex_effect_workspace_bg_g\";s:0:\"\";s:25:\"rex_effect_workspace_bg_b\";s:0:\"\";}}',1,1369425424,'root',1369425424,'root'),
  (12,448053,'resize','a:8:{s:15:\"rex_effect_crop\";a:6:{s:21:\"rex_effect_crop_width\";s:0:\"\";s:22:\"rex_effect_crop_height\";s:0:\"\";s:28:\"rex_effect_crop_offset_width\";s:0:\"\";s:29:\"rex_effect_crop_offset_height\";s:0:\"\";s:20:\"rex_effect_crop_hpos\";s:6:\"center\";s:20:\"rex_effect_crop_vpos\";s:6:\"middle\";}s:22:\"rex_effect_filter_blur\";a:3:{s:29:\"rex_effect_filter_blur_amount\";s:2:\"80\";s:29:\"rex_effect_filter_blur_radius\";s:1:\"8\";s:32:\"rex_effect_filter_blur_threshold\";s:1:\"3\";}s:25:\"rex_effect_filter_sharpen\";a:3:{s:32:\"rex_effect_filter_sharpen_amount\";s:2:\"80\";s:32:\"rex_effect_filter_sharpen_radius\";s:3:\"0.5\";s:35:\"rex_effect_filter_sharpen_threshold\";s:1:\"3\";}s:15:\"rex_effect_flip\";a:1:{s:20:\"rex_effect_flip_flip\";s:1:\"X\";}s:23:\"rex_effect_insert_image\";a:5:{s:34:\"rex_effect_insert_image_brandimage\";s:0:\"\";s:28:\"rex_effect_insert_image_hpos\";s:4:\"left\";s:28:\"rex_effect_insert_image_vpos\";s:3:\"top\";s:33:\"rex_effect_insert_image_padding_x\";s:3:\"-10\";s:33:\"rex_effect_insert_image_padding_y\";s:3:\"-10\";}s:17:\"rex_effect_mirror\";a:5:{s:24:\"rex_effect_mirror_height\";s:0:\"\";s:33:\"rex_effect_mirror_set_transparent\";s:7:\"colored\";s:22:\"rex_effect_mirror_bg_r\";s:0:\"\";s:22:\"rex_effect_mirror_bg_g\";s:0:\"\";s:22:\"rex_effect_mirror_bg_b\";s:0:\"\";}s:17:\"rex_effect_resize\";a:4:{s:23:\"rex_effect_resize_width\";s:2:\"80\";s:24:\"rex_effect_resize_height\";s:2:\"80\";s:23:\"rex_effect_resize_style\";s:5:\"exact\";s:31:\"rex_effect_resize_allow_enlarge\";s:7:\"enlarge\";}s:20:\"rex_effect_workspace\";a:8:{s:26:\"rex_effect_workspace_width\";s:0:\"\";s:27:\"rex_effect_workspace_height\";s:0:\"\";s:25:\"rex_effect_workspace_hpos\";s:4:\"left\";s:25:\"rex_effect_workspace_vpos\";s:3:\"top\";s:36:\"rex_effect_workspace_set_transparent\";s:7:\"colored\";s:25:\"rex_effect_workspace_bg_r\";s:0:\"\";s:25:\"rex_effect_workspace_bg_g\";s:0:\"\";s:25:\"rex_effect_workspace_bg_b\";s:0:\"\";}}',1,1369425544,'root',1369425481,'root');
/*!40000 ALTER TABLE `rex_679_type_effects` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_679_types`;
CREATE TABLE `rex_679_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=448054 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_679_types` WRITE;
/*!40000 ALTER TABLE `rex_679_types` DISABLE KEYS */;
INSERT INTO `rex_679_types` VALUES 
  (1,1,'rex_mediapool_detail','Zur Darstellung von Bildern in der Detailansicht im Medienpool'),
  (2,1,'rex_mediapool_maximized','Zur Darstellung von Bildern im Medienpool wenn maximiert'),
  (3,1,'rex_mediapool_preview','Zur Darstellung der Vorschaubilder im Medienpool'),
  (4,1,'rex_mediabutton_preview','Zur Darstellung der Vorschaubilder in REX_MEDIA_BUTTON[]s'),
  (5,1,'rex_medialistbutton_preview','Zur Darstellung der Vorschaubilder in REX_MEDIALIST_BUTTON[]s'),
  (6,0,'contentimage_full',''),
  (7,0,'contentimage_noresize',''),
  (8,0,'contentimage_half',''),
  (9,0,'contentimage_quarter','');
/*!40000 ALTER TABLE `rex_679_types` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_action`;
CREATE TABLE `rex_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `preview` text,
  `presave` text,
  `postsave` text,
  `previewmode` tinyint(4) DEFAULT NULL,
  `presavemode` tinyint(4) DEFAULT NULL,
  `postsavemode` tinyint(4) DEFAULT NULL,
  `createuser` varchar(255) NOT NULL,
  `createdate` int(11) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `updatedate` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_ahoi_widgets_blocks`;
CREATE TABLE `rex_ahoi_widgets_blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `wrapper` varchar(255) NOT NULL DEFAULT 'none',
  `widgets` varchar(255) NOT NULL DEFAULT '',
  `lang` varchar(255) NOT NULL DEFAULT '1',
  `langlist` varchar(255) NOT NULL DEFAULT '',
  `page` varchar(255) NOT NULL DEFAULT '1',
  `pagelist` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_ahoi_widgets_blocks` WRITE;
/*!40000 ALTER TABLE `rex_ahoi_widgets_blocks` DISABLE KEYS */;
INSERT INTO `rex_ahoi_widgets_blocks` VALUES 
  (1,'header','header','none','','1','','1','',1),
  (2,'article','article','none','','1','','1','',1),
  (3,'aside','aside','none','','1','','1','',1),
  (4,'footer','footer','none','','1','','1','',1);
/*!40000 ALTER TABLE `rex_ahoi_widgets_blocks` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_ahoi_widgets_widgets`;
CREATE TABLE `rex_ahoi_widgets_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `wrapper` varchar(255) NOT NULL DEFAULT 'none',
  `params` text NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '1',
  `widget` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '1',
  `input` longtext NOT NULL,
  `output` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_article`;
CREATE TABLE `rex_article` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL,
  `re_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `catname` varchar(255) NOT NULL,
  `catprior` int(11) NOT NULL,
  `attributes` text NOT NULL,
  `startpage` tinyint(1) NOT NULL,
  `prior` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `createdate` int(11) NOT NULL,
  `updatedate` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `clang` int(11) NOT NULL,
  `createuser` varchar(255) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `revision` int(11) NOT NULL,
  `art_online_from` text,
  `art_online_to` text,
  `art_description` text,
  `art_file` varchar(255) DEFAULT '',
  `art_teaser` varchar(255) DEFAULT '',
  `art_type_id` varchar(255) DEFAULT '',
  `seo_title` text,
  `seo_description` text,
  `seo_keywords` text,
  `seo_custom_url` text,
  `seo_canonical_url` text,
  `seo_noindex` varchar(1) DEFAULT NULL,
  `seo_ignore_prefix` varchar(1) DEFAULT NULL,
  `art_keywords` text,
  `art_rexseo_legend` text,
  `art_rexseo_url` text,
  `art_rexseo_canonicalurl` text,
  `art_rexseo_title` text,
  `art_rexseo_sitemap_legend` text,
  `art_rexseo_priority` varchar(255) DEFAULT '',
  `art_rexseo_changefreq` varchar(255) DEFAULT '',
  `art_rexseo_sitemap_out` varchar(255) DEFAULT '',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `find_articles` (`id`,`clang`),
  KEY `id` (`id`),
  KEY `clang` (`clang`),
  KEY `re_id` (`re_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_article` WRITE;
/*!40000 ALTER TABLE `rex_article` DISABLE KEYS */;
INSERT INTO `rex_article` VALUES 
  (1,1,0,'Home','Home',1,'',1,1,'|',1,1377518652,1384169618,1,0,'olien','olien',0,'','','','','','','','','','','','','','','','','','','','','',''),
  (2,2,0,'Wartungsarbeiten','',0,'',0,1,'|',1,1365071764,1365072133,2,0,'olien','olien',0,'','','','','','','','','','','','','','','','','','','','','',''),
  (8,4,0,'Beispiele','Beispiele',3,'',1,1,'|',1,1383734925,1383826133,1,0,'olien','olien',0,'','','','','','','','','','','','','','','','','','','','','',''),
  (7,3,0,'404 Seite','',0,'',0,2,'|',1,1382685559,1382685568,1,0,'olien','olien',0,'','','','','','','','','','','','','','','','','','','','','',''),
  (9,5,0,'separator: ','separator: ',2,'',1,1,'|',0,1383734936,1383734936,1,0,'olien','olien',0,'','','','','','','','','','','','','','','','','','','','','','');
/*!40000 ALTER TABLE `rex_article` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_article_slice`;
CREATE TABLE `rex_article_slice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clang` int(11) NOT NULL,
  `ctype` int(11) NOT NULL,
  `re_article_slice_id` int(11) NOT NULL,
  `value1` text,
  `value2` text,
  `value3` text,
  `value4` text,
  `value5` text,
  `value6` text,
  `value7` text,
  `value8` text,
  `value9` text,
  `value10` text,
  `value11` text,
  `value12` text,
  `value13` text,
  `value14` text,
  `value15` text,
  `value16` text,
  `value17` text,
  `value18` text,
  `value19` text,
  `value20` text,
  `file1` varchar(255) DEFAULT NULL,
  `file2` varchar(255) DEFAULT NULL,
  `file3` varchar(255) DEFAULT NULL,
  `file4` varchar(255) DEFAULT NULL,
  `file5` varchar(255) DEFAULT NULL,
  `file6` varchar(255) DEFAULT NULL,
  `file7` varchar(255) DEFAULT NULL,
  `file8` varchar(255) DEFAULT NULL,
  `file9` varchar(255) DEFAULT NULL,
  `file10` varchar(255) DEFAULT NULL,
  `filelist1` text,
  `filelist2` text,
  `filelist3` text,
  `filelist4` text,
  `filelist5` text,
  `filelist6` text,
  `filelist7` text,
  `filelist8` text,
  `filelist9` text,
  `filelist10` text,
  `link1` varchar(10) DEFAULT NULL,
  `link2` varchar(10) DEFAULT NULL,
  `link3` varchar(10) DEFAULT NULL,
  `link4` varchar(10) DEFAULT NULL,
  `link5` varchar(10) DEFAULT NULL,
  `link6` varchar(10) DEFAULT NULL,
  `link7` varchar(10) DEFAULT NULL,
  `link8` varchar(10) DEFAULT NULL,
  `link9` varchar(10) DEFAULT NULL,
  `link10` varchar(10) DEFAULT NULL,
  `linklist1` text,
  `linklist2` text,
  `linklist3` text,
  `linklist4` text,
  `linklist5` text,
  `linklist6` text,
  `linklist7` text,
  `linklist8` text,
  `linklist9` text,
  `linklist10` text,
  `php` text,
  `html` text,
  `article_id` int(11) NOT NULL,
  `modultyp_id` int(11) NOT NULL,
  `createdate` int(11) NOT NULL,
  `updatedate` int(11) NOT NULL,
  `createuser` varchar(255) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `next_article_slice_id` int(11) DEFAULT NULL,
  `revision` int(11) NOT NULL,
  `status` tinyint(1) unsigned zerofill NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`re_article_slice_id`,`article_id`,`modultyp_id`),
  KEY `id` (`id`),
  KEY `clang` (`clang`),
  KEY `re_article_slice_id` (`re_article_slice_id`),
  KEY `article_id` (`article_id`),
  KEY `find_slices` (`clang`,`article_id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_article_slice` WRITE;
/*!40000 ALTER TABLE `rex_article_slice` DISABLE KEYS */;
INSERT INTO `rex_article_slice` VALUES 
  (1,0,1,0,'Wartungsarbeiten','h1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',2,1,1365071775,1365071775,'olien','olien',0,0,1),
  (2,0,1,1,'Diese Webseite wird gerade überarbeitet','','','left','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',2,2,1365072052,1365072079,'olien','olien',0,0,1),
  (45,0,1,0,'Überschrift','h1','*Vivamus* sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas faucibus _mollis_ interdum. +Lorem+ ipsum dolor sit amet, consectetur adipiscing elit.\r\nDonec ullamcorper nulla non metus auctor fringilla. Nullam id dolor id nibh ultricies vehicula ut id elit. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.\r\n\r\nVivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Nullam quis risus eget urna mollis ornare vel eu leo. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Donec ullamcorper nulla non metus auctor fringilla.','','','','tl','half','','','lll','','nurbildlink','','','','','','','','','','','','','','','','','','','','','','','','','','','','3','','','','','','','','','','','','','','','','','','','','','',1,8,1378713662,1383743205,'olien','olien',0,0,1),
  (51,0,1,0,'Überschrift Level 1','h1','*Pellentesque habitant morbi tristique* senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. _Aenean ultricies mi vitae est._ Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, <code>commodo vitae</code>, ornare sit amet, wisi.- Aenean fermentum-, elit eget tincidunt condimentum, +eros ipsum rutrum orci+, sagittis tempus lacus enim ac dui. Donec non enim</a> in turpis pulvinar facilisis. Ut felis.\r\n\r\n*fett*\r\n_kursiv_\r\n-durchgestrichen-\r\n+unterstrichen+\r\n\"Ein interner Link\":redaxo://1\r\n\"Ein externer Link\":http://redaxo.org\r\n\"eine E-Mail Adresse\":mailto:test@test.de\r\na ^2^ + b ^2^ = c ^2^\r\nlog ~2~ x','','','','l','noresize','','','','','nurbildlink','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',4,8,1383750732,1383753020,'olien','olien',0,0,1),
  (49,0,1,0,'404','h1','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',3,1,1382685568,1382685568,'olien','olien',0,0,1),
  (54,0,1,51,'Überschrift Level 2','h2','*geordnete Liste*\r\n	       \r\n# Lorem ipsum dolor sit amet, consectetuer adipiscing elit\r\n# Aliquam tincidunt mauris eu risus.Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est.\r\n## Konsectetur adipiscing elit. Vivamus magna. \r\n# Ödolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet cong\r\n\r\n*Zitat*\r\n\r\n<blockquote>orem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet congue. Ut a est eget ligula molestie gravida. Curabitur massa. Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est.</blockquote>','','','','l','noresize','','','','','nurbildlink','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',4,8,1383751996,1383753105,'olien','olien',0,0,1),
  (55,0,1,54,'Überschrift Level 3','h3','*unsortierte Liste*\r\n\r\n* Lorem ipsum dolor sit amet, consectetuer adipiscing elit. . Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est.\r\n** Rtellus est malesuada tellus, at luctus\r\n* Aliquam tincidunt mauris eu risus.\r\n\r\n<pre><code>\r\n#header h1 a { \r\n	display: block; \r\n	width: 300px; \r\n	height: 80px; \r\n}\r\n</code></pre>','','','','l','noresize','','','','','nurbildlink','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',4,8,1383752101,1383753083,'olien','olien',0,0,1),
  (56,0,1,55,'Text und Bild','h2','Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi.- Aenean fermentum-, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis.','','Alternativtext zum Bild','Bildunterschrift','l','half','1','','','','nurbildlink','','','','','','','','h5_1.jpg','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',4,8,1383826133,1383826133,'olien','olien',0,0,1);
/*!40000 ALTER TABLE `rex_article_slice` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_clang`;
CREATE TABLE `rex_clang` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `revision` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `rex_clang` WRITE;
/*!40000 ALTER TABLE `rex_clang` DISABLE KEYS */;
INSERT INTO `rex_clang` VALUES 
  (0,'deutsch',0);
/*!40000 ALTER TABLE `rex_clang` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_file`;
CREATE TABLE `rex_file` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `re_file_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `attributes` text,
  `filetype` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `originalname` varchar(255) DEFAULT NULL,
  `filesize` varchar(255) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `createdate` int(11) NOT NULL,
  `updatedate` int(11) NOT NULL,
  `createuser` varchar(255) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `revision` int(11) NOT NULL,
  `med_description` text,
  `med_copyright` text,
  PRIMARY KEY (`file_id`),
  KEY `re_file_id` (`re_file_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_file` WRITE;
/*!40000 ALTER TABLE `rex_file` DISABLE KEYS */;
INSERT INTO `rex_file` VALUES 
  (15,0,4,'','image/jpeg','r2.jpg','r2.jpg','139906',1200,1200,'',1383743168,1383743182,'olien','olien',0,'',''),
  (16,0,4,'','image/jpeg','h3.jpg','h3.jpg','53838',600,1200,'',1383743168,1383743182,'olien','olien',0,'',''),
  (17,0,4,'','image/jpeg','h5.jpg','h5.jpg','100117',600,1200,'',1383743168,1383743182,'olien','olien',0,'',''),
  (18,0,4,'','image/jpeg','r3.jpg','r3.jpg','170188',1200,1200,'',1383743168,1383743182,'olien','olien',0,'',''),
  (19,0,4,'','image/jpeg','h1.jpg','h1.jpg','85095',600,1200,'',1383743168,1383743182,'olien','olien',0,'',''),
  (20,0,4,'','image/jpeg','q2.jpg','q2.jpg','62364',1200,600,'',1383743168,1383743182,'olien','olien',0,'',''),
  (21,0,4,'','image/jpeg','r4.jpg','r4.jpg','99718',1200,1200,'',1383743168,1383743182,'olien','olien',0,'',''),
  (22,0,4,'','image/jpeg','q5.jpg','q5.jpg','141534',1200,600,'',1383743168,1383743182,'olien','olien',0,'',''),
  (23,0,4,'','image/jpeg','h4.jpg','h4.jpg','63607',600,1200,'',1383743169,1383743182,'olien','olien',0,'',''),
  (24,0,4,'','image/jpeg','q1.jpg','q1.jpg','64847',1200,600,'',1383743169,1383743182,'olien','olien',0,'',''),
  (25,0,4,'','image/jpeg','q3.jpg','q3.jpg','144692',1200,600,'',1383743169,1383743182,'olien','olien',0,'',''),
  (26,0,4,'','image/jpeg','h2.jpg','h2.jpg','24410',600,1200,'',1383743169,1383743182,'olien','olien',0,'',''),
  (27,0,4,'','image/jpeg','q4.jpg','q4.jpg','135121',1200,600,'',1383743169,1383743182,'olien','olien',0,'',''),
  (28,0,4,'','image/jpeg','r5.jpg','r5.jpg','118763',1200,1200,'',1383743169,1383743182,'olien','olien',0,'',''),
  (29,0,4,'','image/jpeg','r1.jpg','r1.jpg','264780',1200,1200,'',1383743169,1383743182,'olien','olien',0,'',''),
  (30,0,4,'','image/jpeg','q3_1.jpg','q3_1.jpg','144692',1200,600,'',1383749987,1383749987,'olien','olien',0,'',''),
  (31,0,4,'','image/jpeg','r1_1.jpg','r1_1.jpg','264780',1200,1200,'',1383749987,1383749987,'olien','olien',0,'',''),
  (32,0,4,'','image/jpeg','q4_1.jpg','q4_1.jpg','135121',1200,600,'',1383749987,1383749987,'olien','olien',0,'',''),
  (33,0,4,'','image/jpeg','h2_1.jpg','h2_1.jpg','24410',600,1200,'',1383749987,1383749987,'olien','olien',0,'',''),
  (34,0,4,'','image/jpeg','q2_1.jpg','q2_1.jpg','62364',1200,600,'',1383749987,1383749987,'olien','olien',0,'',''),
  (35,0,4,'','image/jpeg','h1_1.jpg','h1_1.jpg','85095',600,1200,'',1383749987,1383749987,'olien','olien',0,'',''),
  (36,0,4,'','image/jpeg','h3_1.jpg','h3_1.jpg','53838',600,1200,'',1383749987,1383749987,'olien','olien',0,'',''),
  (37,0,4,'','image/jpeg','r3_1.jpg','r3_1.jpg','170188',1200,1200,'',1383749988,1383749988,'olien','olien',0,'',''),
  (38,0,4,'','image/jpeg','h5_1.jpg','h5_1.jpg','100117',600,1200,'',1383749988,1383749988,'olien','olien',0,'',''),
  (39,0,4,'','image/jpeg','h4_1.jpg','h4_1.jpg','63607',600,1200,'',1383749988,1383749988,'olien','olien',0,'',''),
  (40,0,4,'','image/jpeg','q5_1.jpg','q5_1.jpg','141534',1200,600,'',1383749988,1383749988,'olien','olien',0,'',''),
  (41,0,4,'','image/jpeg','r2_1.jpg','r2_1.jpg','139906',1200,1200,'',1383749988,1383749988,'olien','olien',0,'',''),
  (42,0,4,'','image/jpeg','r5_1.jpg','r5_1.jpg','118763',1200,1200,'',1383749988,1383749988,'olien','olien',0,'',''),
  (43,0,4,'','image/jpeg','q1_1.jpg','q1_1.jpg','64847',1200,600,'',1383749988,1383749988,'olien','olien',0,'',''),
  (44,0,4,'','image/jpeg','r4_1.jpg','r4_1.jpg','99718',1200,1200,'',1383749988,1383749988,'olien','olien',0,'','');
/*!40000 ALTER TABLE `rex_file` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_file_category`;
CREATE TABLE `rex_file_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `re_id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `createdate` int(11) NOT NULL,
  `updatedate` int(11) NOT NULL,
  `createuser` varchar(255) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `attributes` text,
  `revision` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `re_id` (`re_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_file_category` WRITE;
/*!40000 ALTER TABLE `rex_file_category` DISABLE KEYS */;
INSERT INTO `rex_file_category` VALUES 
  (4,'5010 - Test- und Beispieldateien',0,'|',1383743146,1383743146,'olien','olien','',0),
  (5,'5000 - ----',0,'|',1383743153,1383743153,'olien','olien','',0);
/*!40000 ALTER TABLE `rex_file_category` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_module`;
CREATE TABLE `rex_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  `ausgabe` text NOT NULL,
  `eingabe` text NOT NULL,
  `createuser` varchar(255) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `createdate` int(11) NOT NULL,
  `updatedate` int(11) NOT NULL,
  `attributes` text,
  `revision` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_module` WRITE;
/*!40000 ALTER TABLE `rex_module` DISABLE KEYS */;
INSERT INTO `rex_module` VALUES 
  (1,'0010 - Überschrift',0,'<?php\r\n\r\n$textile1 = htmlspecialchars_decode(\'REX_VALUE[1]\');\r\n$textile1 = str_replace(\'<br />\', \'\', $textile1);\r\n\r\nif(!$REX[\'REDAXO\']) {\r\n    echo \'<REX_VALUE[2]>\'.$textile1.\'</REX_VALUE[2]>\'.\"\\r\\n\";\r\n} else {\r\n	echo \'<b>Grösse: </b>REX_VALUE[2]\';\r\n	echo \'<br/>\';\r\n	echo \'<b>Text:</b> REX_VALUE[1]\';\r\n}\r\n?>','<?php\r\n\r\n$objForm = new mform();\r\n\r\n$objForm->addHeadline(\'Überschrift\');\r\n\r\n$objForm->addTextAreaField(1,array(\'label\'=>\'Text\',\'style\'=>\'width:515px;height:40px\'));\r\n\r\n$objForm->addSelectField(2,array(\'h1\'=>\'H1 (pro Seite nur einmal verwenden!)\',\'h2\'=>\'H2\',\'h3\'=>\'H3\',\'h4\'=>\'H4\',\'h5\'=>\'H5\',\'h6\'=>\'H6\'),array(\'label\'=>\'Grösse\'));\r\n\r\necho $objForm->show_mform();\r\n\r\n?>\r\n\r\n','olien','olien',1365071685,1377519964,'',0),
  (6,'0060 - Abstand einfügen',0,'<?php\r\n\r\nif ($REX[\'REDAXO\']) {\r\necho  \'Höhe: REX_VALUE[1] px\';\r\n} else {\r\necho \'<span class=\"abstand\" style=\"height: REX_VALUE[1]px\"></span>\';\r\n}\r\n?>','<?php\r\n\r\n$objForm = new mform();\r\n\r\n$objForm->addHeadline(\'Abstand einfügen\');\r\n\r\n$objForm->addTextField(1,array(\'label\'=>\'Höhe in Pixel\',\'style\'=>\'width:150px\'));\r\n\r\necho $objForm->show_mform();\r\n\r\n\r\n?>','olien','',1377519990,0,'',0),
  (7,'0400 - Linkliste',0,'<?php\r\n\r\n$ausgabe = \'\';\r\n\r\n$arr = explode(\',\',\'REX_LINKLIST[1]\');\r\n\r\n$letztesElement = end($arr); \r\n\r\n$aktuelleArtikelID = $REX[\'ARTICLE_ID\'];\r\n\r\nforeach ($arr as $value)\r\n{\r\n  $article = OOArticle::getArticleById($value);\r\n \r\n  if(is_object($article))\r\n  {\r\n	$artikelid = $article->getID();\r\n	\r\n	if ($artikelid == $letztesElement) { $klasse_last = \'class=\"last\"\';} else { $klasse_last = \'\';}\r\n	if ($artikelid == $aktuelleArtikelID ) { $klasse_active = \'class=\"aktiv\"\';} else { $klasse_active = \'\';}\r\n	\r\n	$ausgabe .= \'<li><a \'.$klasse_active.\' href=\"\'.rex_getUrl($value, $REX[\'CUR_CLANG\']).\'\" title=\"\'.$article->getName().\'\">\'.$article->getName().\'</a></li>\'.PHP_EOL;		\r\n\r\n  }\r\n}\r\n\r\necho \'<ul>\'.\"\\r\\n\";\r\necho $ausgabe;\r\necho \'</ul>\'.\"\\r\\n\";\r\n?>','<?php\r\n\r\n$objForm = new mform();\r\n\r\n$objForm->addHeadline(\'Linkliste\');\r\n\r\n$objForm->addLinklistField(1,array(\'label\'=>\'Seiten\'));\r\necho $objForm->show_mform();\r\n\r\n?>\r\n\r\n','olien','',1377520045,0,'',0),
  (2,'0020 - Text und / oder Bild',0,'<?php\r\n\r\nif(!$REX[\'REDAXO\']) {\r\n			 if(OOAddon::isAvailable(\'textile\'))\r\n			{\r\n			  echo \'<div class=\"textbild\">\'.\"\\r\\n\";\r\n			\r\n			  //  Ausrichtung des Bildes \r\n			  if (\"REX_VALUE[4]\" == \"left\") $float = \"floatLeft\";\r\n			  if (\"REX_VALUE[4]\" == \"right\") $float = \"floatRight\";\r\n			\r\n			  //  Wenn Bild eingefuegt wurde, Code schreiben \r\n			  $file = \"\";\r\n			  if (\"REX_FILE[1]\" != \"\") {\r\n			  	$file = \'<div class=\"\'.$float.\'\">\r\n			 <img src=\"\'.$REX[\'HTDOCS_PATH\'].\'files/REX_FILE[1]\" title=\"\'.\"REX_VALUE[2]\".\'\" alt=\"\'.\"REX_VALUE[2]\".\'\" />\r\n			 <span class=\"subline\">REX_VALUE[3]</span>\r\n			</div>\'.\"\\r\\n\";\r\n			  	}\r\n			\r\n			  $textile = \'\';\r\n			  if(REX_IS_VALUE[1])\r\n			  {\r\n			    $textile = htmlspecialchars_decode(\"REX_VALUE[1]\");\r\n			    $textile = str_replace(\"<br />\",\"\",$textile);\r\n			    $textile = rex_a79_textile($textile);\r\n			    $textile = str_replace(\"###\",\"&#x20;\",$textile);\r\n			  } \r\n			  print $file.$textile.\"\\r\\n\";\r\n			\r\n			  echo \'</div>\'.\"\\r\\n\";\r\n			  echo \'<div class=\"clboth\"></div>\'.\"\\r\\n\";\r\n			\r\n			}\r\n			else\r\n			{\r\n			  echo rex_warning(\'Dieses Modul benötigt das \"textile\" Addon!\');\r\n			}\r\n} else {\r\n	\r\n	echo \'<b>Text:</b> REX_VALUE[1]\';\r\n	echo \'<br/>\';\r\n\r\n    if (\"REX_VALUE[4]\" == \"left\") $ausrichtung = \"links vom Text\";\r\n    if (\"REX_VALUE[4]\" == \"right\") $ausrichtung = \"links vom Text\";\r\n			\r\n    //  Wenn Bild eingefuegt wurde, Code schreiben \r\n    if (\"REX_FILE[1]\" != \"\") {\r\n	echo \'<br/>\'.\"\\r\\n\";		  \r\n    echo \'<b>Dateiname:</b> REX_FILE[1]\'.\"\\r\\n\";\r\n	echo \'<br/>\'.\"\\r\\n\";\r\n	echo \'<b>Titel:</b> REX_VALUE[2]\'.\"\\r\\n\";			  \r\n	echo \'<br/>\'.\"\\r\\n\";\r\n	echo \'<b>Bildunterschrift:</b> REX_VALUE[3]\'.\"\\r\\n\";\r\n	echo \'<br/>\'.\"\\r\\n\";\r\n	echo \'<b>Ausrichtung:</b> \'.$ausrichtung.\"\\r\\n\";	\r\n	echo \'<br/>\'.\"\\r\\n\";\r\n    echo \'<b>Bild:</b>\'.\"\\r\\n\";\r\n	echo \'<br/>\'.\"\\r\\n\";\r\n	echo \'<img src=\" index.php?rex_img_type=rex_mediabutton_preview&rex_img_file=REX_FILE[1]\" title=\"\'.\"REX_VALUE[2]\".\'\" alt=\"\'.\"REX_VALUE[2]\".\'\" />\'.\"\\r\\n\";\r\n	}\r\n\r\n\r\n}\r\n\r\n?>','<div class=\"container\" >\r\n<h3>Text</h3>\r\n	<strong>Text</strong>\r\n	<span class=\"right\">\r\n		<textarea name=\"VALUE[1]\" class=\"rex-markitup\">REX_VALUE[1]</textarea>\r\n	</span>\r\n	<div class=\"clboth\"></div>\r\n</div>\r\n\r\n<div class=\"container\" >\r\n<h3>Bild</h3>\r\n	<strong>Bild</strong>\r\n	<span class=\"right\">REX_MEDIA_BUTTON[1]</span>\r\n	\r\n	\r\n	<strong>Title</strong>\r\n	<span class=\"right\"><input type=\"text\" name=\"VALUE[2]\" value=\"REX_VALUE[2]\" /></span>\r\n	\r\n	<strong>Bildunterschrift</strong>\r\n	<span class=\"right\"><input type=\"text\" name=\"VALUE[3]\" value=\"REX_VALUE[3]\" /></span>\r\n	\r\n	<strong>Ausrichtung</strong>\r\n	<span class=\"right\">\r\n	<select name=\"VALUE[4]\">\r\n		<option value=\'left\' <?php if (\"REX_VALUE[4]\" == \'left\') echo \'selected\'; ?>>links vom Text</option>\r\n		<option value=\'right\' <?php if (\"REX_VALUE[4]\" == \'right\') echo \'selected\'; ?>>rechts vom Text</option>\r\n	</select>\r\n	</span>\r\n	<div class=\"clboth\"></div>\r\n</div>\r\n\r\n\r\n\r\n','olien','olien',1365071699,1383735324,'',0),
  (9,'df',0,'<?php\r\n\r\n\r\n\r\n\r\n# Variablen für Online-Prüfung\r\n	$online = \'REX_VALUE[20]\';\r\n	$time = time();\r\n	$start = strtotime(\'REX_VALUE[19]\');\r\n	$end = strtotime(\'REX_VALUE[18]\');\r\n\r\necho \'REX_VALUE[20]<br />\';\r\necho \'REX_VALUE[19]<br />\';\r\necho \'REX_VALUE[18]<br />\';\r\n\r\n\r\necho $online.\'<br />\';\r\necho $time.\'<br />\';\r\necho $start.\'<br />\';\r\necho $end.\'<br />\';\r\n\r\nif(OOAddon::isAvailable(\'textile\'))\r\n{\r\n  // Fliesstext \r\n  $content = \'\';\r\n  if(REX_IS_VALUE[1])\r\n  {\r\n    $content = htmlspecialchars_decode(\"REX_VALUE[1]\");\r\n    $content = str_replace(\"<br />\",\"\",$content);\r\n    $content = rex_a79_textile($content);\r\n    $content = str_replace(\"###\",\"&#x20;\",$content);\r\n    //print \'<div class=\"txt-img\">\'. $content . \'</div>\';\r\n  } \r\n}\r\nelse\r\n{\r\n  echo rex_warning(\'Dieses Modul benötigt das \"textile\" Addon!\');\r\n}\r\n\r\n\r\n\r\n\r\n\r\n# Ausgabe im Backend\r\n# Infobox Statusanzeige\r\nif($REX[\'REDAXO\'])	{\r\n	echo \'<div style=\"background-color: #e6eec6; padding: 10px; border: solid 1px grey;\">\';\r\n	if ($online == \"on\") {\r\n		echo \'<span style=\"color: green;\"><strong>Online-Prüfung ist aktiviert.</strong></span> \';\r\n	} \r\n	else {\r\n		echo \'<span style=\"color: red;\"><strong>Online-Prüfung ist deaktiviert.</strong></span> \';\r\n	}\r\n	  	echo  \'<strong>Online von:</strong> \'.date(\'d.m.Y H:i\',$start).\' | \';     \r\n	  	echo  \'<strong>Online bis:</strong> \'.date(\'d.m.Y H:i\',$end).\' | \';    \r\n	  	echo  \'<strong>Aktuelle Zeit:</strong> \'.date(\'d.m.Y H:i\',$time).\'\'; \r\n# Prüfung an\r\n	if ($online == \"on\") {\r\n	\r\n		if( $time > $start && $time < $end )\r\n		{\r\n		    echo \'<br /><span style=\"color: green;\">Inhalt wird angezeit. Zeit ist aktiv!</span>\';\r\n		}\r\n		else {\r\n			echo \'<br /><span style=\"color: red;\">Inhalt nicht anzeigen. Zeit ist abgelaufen!!</span>\';\r\n		}\r\n	}\r\n# Prüfung aus\r\n	if ($online == \"\") {\r\n	    echo \'<br /><span style=\"color: green;\">Inhalt immer anzeigen. Prüfung ist deaktiviert!</span>\';\r\n	  }\r\n	  	\r\n	  	\r\n	  	echo \'<br /><hr /><span style=\"margin: 10px 0 10px 0; color: red;\"><strong>Die Ausgabe erfolgt immer im Backend zu Kontrollzwecken, im Frontend abhängig von der Online-Prüfung!</strong></span>\';\r\n	  	echo \'</div>\';\r\n	  	echo $content;\r\n}\r\n# Ende der Statusanzeige\r\n\r\n\r\n# Modulausgabe ab hier\r\nif(!$REX[\'REDAXO\'])	{\r\n# Prüfung an\r\n	\r\n//	echo $content;\r\n	\r\n	if ($online == \"on\") {\r\n	\r\n		if( $time > $start && $time < $end )\r\n		{\r\n		    	    \r\n		    echo $content;\r\n		}\r\n		else {\r\n			echo \'\';\r\n		}\r\n	}\r\n# Prüfung aus\r\n	if ($online == \"\") {\r\n	    echo $content;\r\n	  }\r\n}\r\n\r\n\r\n\r\n?>\r\n\r\n\r\n\r\n\r\n\r\n','<div style=\"background-color: #e6eec6; padding: 10px; border: solid 1px grey;\">\r\n<table width=\"100%\">\r\n<tr>\r\n	<td width=\"250px\">\r\n	<strong>Online von/bis-Zeit ber&uuml;cksichtigen?</strong>\r\n		<?php\r\n		 if(\"REX_VALUE[20]\" == \"on\" || \"REX_VALUE[20]\" == \"On\" || \"REX_VALUE[20]\" == 1)\r\n			{\r\n		    	echo(\'<input type=\"checkbox\" checked=\"checked\" id=\"online\" name=\"VALUE[20]\">\');\r\n		    }\r\n		  else\r\n		    {\r\n		     	echo(\'<input type=\"checkbox\" id=\"online\" name=\"VALUE[20]\">\');\r\n		    }\r\n		?>\r\n		</td>\r\n		<td width=\"150px\">\r\n			von: <input type=\"text\" size=\"15\" name=\"VALUE[19]\" value=\"REX_VALUE[19]\" />\r\n		</td>\r\n		<td>\r\n			bis: <input type=\"text\" size=\"15\" name=\"VALUE[18]\" value=\"REX_VALUE[18]\" />\r\n		</td>\r\n</tr>\r\n</table>\r\n</div>\r\n<br /><br />\r\n<?php\r\n\r\nif(OOAddon::isAvailable(\'textile\'))\r\n{\r\n?>\r\n\r\n<strong>Fliesstext</strong>:<br />\r\n<textarea name=\"VALUE[1]\" cols=\"80\" rows=\"10\" class=\"inp100\">REX_HTML_VALUE[1]</textarea>\r\n<br />\r\n\r\n<?php\r\n\r\nrex_a79_help_overview(); \r\n\r\n}else\r\n{\r\n  echo rex_warning(\'Dieses Modul benötigt das \"textile\" Addon!\');\r\n}\r\n\r\n?>','olien','',1377601811,0,'',0),
  (4,'5000 --- ---------------------------------------------',0,'','','olien','olien',1365071728,1373497720,'',0),
  (5,'5010 - PHP',0,'REX_PHP','<!-- Überschrift -->\r\n<div class=\"container\" >\r\n  <h3>PHP</h3>\r\n	<strong>Code</strong>\r\n	<span class=\"right\">\r\n		<textarea name=INPUT_PHP rows=20 >REX_PHP</textarea>\r\n    </span>\r\n	<div class=\"clboth\"></div>\r\n</div>\r\n','olien','olien',1365071741,1373497720,'',0),
  (8,'0010 - Überschrift / Text / Bild / Link',0,'<?php\r\n\r\n	$link 				= \"\";\r\n	$linkbild 			= \"\";\r\n	$linkueberschrift 	= \"\";\r\n	$linkanfang 		= \"\";\r\n	$linkende 			= \"\";		\r\n	$bild 				= \'\';\r\n	$bildunterschrift 	= \'\';\r\n	$weiterlesenlink 	= \'\';\r\n	$bildcode 			= \'\';\r\n\r\n\r\n\r\n# Variablen für Online-Prüfung\r\n	$online = \'REX_VALUE[20]\';\r\n	$time = time();\r\n	$start = strtotime(\'REX_VALUE[19]\');\r\n	$end = strtotime(\'REX_VALUE[18]\');\r\n\r\n$msgonline = \'\r\n<div class=\"rex-message\"><div class=\"rex-info\" style=\"font-size: 15px; font-weight: normal;\"><p><span>Für diesen Inhalt ist ein in Veröffentlichungszeitraum angegeben (REX_VALUE[19] - REX_VALUE[18])<br/><b>Dieser Inhalt wird auf der Webseite angezeigt.</b><span></p></div></div>\';\r\n\r\n$msgoffline = \'\r\n<div class=\"rex-message\"><div class=\"rex-warning\" style=\"font-size: 15px; font-weight: normal;\"><p><span>Für diesen Inhalt ist ein in Veröffentlichungszeitraum angegeben (REX_VALUE[19] - REX_VALUE[18])<br/><b>Dieser Inhalt wird momentan NICHT auf der Webseite angezeigt.</b><span></p></div></div>\';\r\n\r\n\r\nif (!isset($REX[\'base\'][\'textmodulcount\'])){\r\n	$REX[\'base\'][\'textmodulcount\'] = 0;\r\n}\r\n$REX[\'base\'][\'textmodulcount\'] = $REX[\'base\'][\'textmodulcount\'] + 1;\r\n\r\n\r\nif(!$REX[\'REDAXO\']) {\r\n\r\n//\r\n//	Frontend\r\n//\r\n  if(OOAddon::isAvailable(\'textile\'))\r\n	{\r\n\r\n	if(REX_IS_VALUE[3]) { // Text\r\n		$text = \'\';\r\n 		$text = htmlspecialchars_decode(\'REX_VALUE[3]\',ENT_QUOTES);\r\n		$text = str_replace(\'<br />\',\'\',$text);\r\n		$text = rex_a79_textile($text);\r\n	} \r\n\r\n// echo \"REX_FILE[1]\";\r\n\r\n    if (\"REX_FILE[1]\" != \"\") { // Bild\r\n\r\n	  	$bild 				= OOMedia::getMediaByName(\'REX_FILE[1]\');\r\n	   	$bildTitle 			= $bild->getTitle();\r\n	   	$bildBeschreibung 	= $bild->getValue(\'med_description\');\r\n	    $bildCopyright 		= $bild->getValue(\'med_copyright\');\r\n	   	$bildDateiName 		= $bild->getFileName();\r\n	   	$bildBreite 		= $bild->getWidth();\r\n	   	$bildHoehe 			= $bild->getHeight();\r\n\r\n		$image = rex_image_manager::getImageCache(\'REX_FILE[1]\', \"contentimage_REX_VALUE[8]\");\r\n\r\n			//  printf(\'%s[%s] = %d x %d Pixel\',\r\n	  		// $bildDateiName,\r\n	  		// \"contentimage_REX_VALUE[8]\",\r\n	  		// $image->getWidth(),\r\n			// $image->getHeight()\r\n			// );\r\n\r\n	   	if ($bildCopyright != \'\') {\r\n	   		$bildCopyright = \" | (c) \".$bildCopyright;\r\n	   	}\r\n\r\n	$bildunterschrift = \'\';\r\n	if(REX_IS_VALUE[6])   {\r\n 			$bildunterschrift = htmlspecialchars_decode(\'REX_VALUE[6]\',ENT_QUOTES);\r\n			$bildunterschrift = str_replace(\'<br />\',\'\',$bildunterschrift);\r\n			$bildunterschrift = rex_a79_textile($bildunterschrift);\r\n			$bildunterschrift = \'<div class=\"bildunterschrift\">\'.$bildunterschrift.\'</div>\'.PHP_EOL;\r\n	} \r\n\r\n		if(REX_IS_VALUE[9])   { \r\n			$rahmen = \'class=\"rahmen\"\';\r\n		} else {\r\n			$rahmen = \'\';\r\n		}\r\n\r\n\r\n\r\n	$bildcode = \'<img \'.$rahmen.\' src=\"index.php?rex_img_type=contentimage_REX_VALUE[8]&amp;rex_img_file=\'.$bildDateiName.\'\" title=\"REX_VALUE[5]\'.$bildCopyright.\'\" alt=\"REX_VALUE[5]\'.$bildCopyright.\'\" width=\"\'.$image->getWidth().\'\" height=\"\'.$image->getHeight().\'\"/>\'.PHP_EOL;\r\n	}\r\n\r\n \r\n\r\n	 if(REX_IS_VALUE[11] OR \"REX_LINK_ID[1]\" != 0) {\r\n\r\n		$link = \"1\";\r\n	   	$externerlink = \"REX_VALUE[11]\";\r\n	 	  	if($externerlink != str_replace(\"http://\", \"\",$externerlink)) {\r\n				$linkanfang = \'<a href=\"REX_VALUE[11]\">\'.PHP_EOL;\r\n			} else {\r\n				$linkanfang = \'<a href=\"http://REX_VALUE[11]\">\'.PHP_EOL;\r\n			}\r\n	 \r\n 		if (\"REX_LINK_ID[1]\" != 0) {\r\n	  		$linkanfang  = \'<a href=\"\'.rex_geturl(\"REX_LINK_ID[1]\", $REX[\'CUR_CLANG\']).\'\">\'.PHP_EOL;\r\n		  } \r\n	\r\n		$linkende =\'</a>\'.PHP_EOL;\r\n\r\n\r\n		if (\"REX_VALUE[13]\" == \"nurbildlink\") { $linkbild = \"1\"; }\r\n		if (\"REX_VALUE[13]\" == \"ueberschriftlink\") { $linkueberschrift = \"1\"; }\r\n		if (\"REX_VALUE[13]\" == \"ueberschriftundbildlink\") { $linkbild = \"1\"; $linkueberschrift = \"1\";}	\r\n\r\n		$weiterlesenlink = \'\';		\r\n		if (REX_IS_VALUE[10]) {\r\n			$weiterlesenlink = \'<div class=\"weiterlesen\">\'.$linkanfang.\'REX_VALUE[10]\'.$linkende.\'</div>\'.PHP_EOL;\r\n		} else {\r\n			$weiterlesenlink = \'\';\r\n		}\r\n\r\n		}\r\n	\r\n\r\n	// Überschrift\r\n	if ($linkueberschrift) {\r\n		$contentueberschrift = \'<REX_VALUE[2]>\'.$linkanfang.\'REX_VALUE[1]\'.$linkende.\'</REX_VALUE[2]>\'.PHP_EOL;\r\n	} else {\r\n		$contentueberschrift =  \'<REX_VALUE[2]>REX_VALUE[1]</REX_VALUE[2]>\'.PHP_EOL;\r\n	}\r\n\r\n	// Bild\r\n	if ($linkbild) {\r\n		$contentbild = $linkanfang.$bildcode.$linkende.$bildunterschrift;\r\n	} else {\r\n		$contentbild = $bildcode.$bildunterschrift;\r\n	}\r\n\r\n	// Text\r\n	$contenttext = $text;\r\n	$contentweiterlesen = $weiterlesenlink;\r\n\r\n	//HTML\r\n	$content = \'<div class=\"textbildlink\">\'.PHP_EOL;\r\n\r\n	// Ausrichtung \r\n\r\n	$floatimg = \'\';\r\n	$block = \'\';\r\n\r\n	// Ausrichtungen \"im Fliesstext links\"\r\n	if (\"REX_VALUE[7]\" == \'l\' OR \"REX_VALUE[7]\" == \'tl\' OR \"REX_VALUE[7]\" == \'tlu\') {\r\n		$floatimg = \"flLeft\";\r\n	}\r\n\r\n	// Ausrichtungen \"im Fliesstext rechts\"\r\n	if (\"REX_VALUE[7]\" == \'r\' OR \"REX_VALUE[7]\" == \'tr\' OR \"REX_VALUE[7]\" == \'tru\') {\r\n		$floatimg = \"flRight\";\r\n	}\r\n\r\n	if (\"REX_VALUE[7]\" == \'tl\' OR \"REX_VALUE[7]\" == \'tr\' OR \"REX_VALUE[7]\" == \'tlu\' OR \"REX_VALUE[7]\" == \'tru\' ) {\r\n		$block = \'block\';\r\n	} else {\r\n		$block = \'\';\r\n	}\r\n\r\n	if (\"REX_VALUE[7]\" == \'tlu\' OR \"REX_VALUE[7]\" == \'tru\') {\r\n		$content .= \'<div class=\"bildcontainer \'.$floatimg.\' REX_VALUE[8]\">\'.PHP_EOL;\r\n		$content .= $contentbild.\'</div>\'.PHP_EOL;\r\n		$content .= \'<div class=\"text \'.$block.\'\">\'.PHP_EOL;\r\n		$content .= $contentueberschrift.$contenttext.$contentweiterlesen.\'</div>\'.PHP_EOL;\r\n	} else {\r\n		$content .= $contentueberschrift;\r\n		$content .= \'<div class=\"bildcontainer \'.$floatimg.\' REX_VALUE[8]\">\'.PHP_EOL;\r\n		$content .= $contentbild.\'</div>\'.PHP_EOL;\r\n		$content .= \'<div class=\"text \'.$block.\'\">\'.PHP_EOL;\r\n		$content .= $contenttext.$contentweiterlesen.\'</div>\'.PHP_EOL;\r\n	}\r\n\r\n	$content .=  \'</div>\'.PHP_EOL;\r\n\r\n\r\n// Zeiteinstellung\r\n\r\nif ($online == \"1\") {\r\n	\r\n	if( $time > $start && $time < $end )\r\n	{\r\n		if ($REX[\'REDAXO\']) {\r\n			echo $msgonline;\r\n		}\r\n\r\n	echo PHP_EOL.\'<!-- SLICE ID REX_SLICE_ID ANFANG -->\'.PHP_EOL;\r\n	echo $content;\r\n  	echo \'<!-- // -->\'.PHP_EOL;\r\n			\r\n	}\r\n	else {\r\n		if ($REX[\'REDAXO\']) {\r\n		echo $msgoffline;\r\n		}\r\n	}\r\n	}\r\n# Prüfung aus\r\n  if ($online == \"\") {\r\n	echo PHP_EOL.\'<!-- SLICE ID REX_SLICE_ID ANFANG -->\'.PHP_EOL;\r\n	echo $content;\r\n  	echo \'<!-- // -->\'.PHP_EOL;	   \r\n  }\r\n\r\n\r\n	} else {\r\n	  echo rex_warning(\'Dieses Modul benötigt das \"textile\" Addon!\');\r\n	}\r\n} else {\r\n\r\n//\r\n//	Backend\r\n//\r\n\r\n// Eingaben prüfen\r\n$warnings = [];\r\n\r\nif (\"REX_FILE[1]\" != \"\" AND \"REX_VALUE[5]\" == \"\" ) {\r\n    $warnings[] = \'Bitte geben Sie einen Alternativtext für das Bild an.\';\r\n}\r\n\r\nif (\"REX_FILE[1]\" == \"\" AND \"REX_VALUE[5]\" != \"\" OR \"REX_FILE[1]\" == \"\" AND \"REX_VALUE[6]\" != \"\" ) {\r\n    $warnings[] = \'Sie haben Angaben zu einem Bild gemacht ohne ein Bild auszuwählen. Bitte wählen Sie ein Bild aus.\';\r\n}\r\n\r\nif (\"REX_VALUE[10]\" != \"\" AND (\"REX_LINK_ID[1]\" == \"\" AND \"REX_VALUE[11]\" == \"\" )) {\r\n    $warnings[] = \'Bitte geben Sie einen Link an.\';\r\n}\r\n\r\nif (\"REX_VALUE[11]\" != \"\" AND \"REX_LINK_ID[1]\" != \"\") {\r\n    $warnings[] = \'Bitte geben Sie entweder einen externen oder einen internen Link an.\';\r\n} \r\n\r\nif ((\"REX_VALUE[11]\" != \"\" OR \"REX_LINK_ID[1]\" != \"\") AND ((\"REX_VALUE[1]\" == \"\" AND \"REX_VALUE[13]\" == \"ueberschriftlink\") OR (\"REX_VALUE[1]\" == \"\" AND \"REX_VALUE[13]\" == \"ueberschriftundbildlink\"))) {\r\n    $warnings[] = \'Die Überschrift kann nicht verlinkt werden. Bitte geben Sie eine Überschrift ein.\';\r\n}\r\n\r\nif ((\"REX_VALUE[11]\" != \"\" OR \"REX_LINK_ID[1]\" != \"\") AND ((\"REX_FILE[1]\" == \"\" AND \"REX_VALUE[13]\" == \"nurbildlink\") OR (\"REX_FILE[1]\" == \"\" AND \"REX_VALUE[13]\" == \"ueberschriftundbildlink\"))) {\r\n    $warnings[] = \'Das Bild kann nicht verlinkt werden. Bitte wählen Sie ein Bild aus.\';\r\n}\r\n\r\nif ($REX[\'REDAXO\'] && count($warnings) > 0) {\r\n    foreach ($warnings as $warning) {\r\n        echo rex_warning($warning);\r\n    }\r\n}\r\n\r\n	echo \'<table style=\"width: 100%;\">\'.PHP_EOL;\r\n\r\n	if (REX_IS_VALUE[1]) // Überschrift\r\n	{\r\n\r\n		echo \'<tr>\'.PHP_EOL;\r\n		echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Überschrift</td>\'.PHP_EOL;\r\n		echo \'<td style=\"padding: 5px;\">REX_VALUE[1]</td>\'.PHP_EOL;\r\n		echo \'</tr>\'.PHP_EOL;\r\n		echo \'<tr>\'.PHP_EOL;		\r\n		echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Grösse</td>\'.PHP_EOL;\r\n		echo \'<td style=\"padding: 5px;\">REX_VALUE[2]</td>\'.PHP_EOL;\r\n		echo \'</tr>\'.PHP_EOL;\r\n	}\r\n	\r\n	\r\n	if(REX_IS_VALUE[3])\r\n	{\r\n		$text = \'\';\r\n 		$text = htmlspecialchars_decode(\'REX_VALUE[3]\',ENT_QUOTES);\r\n		$text = str_replace(\'<br />\',\'\',$text);\r\n		$text = rex_a79_textile($text);\r\n		\r\n		echo \'<tr>\'.PHP_EOL;\r\n		echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Text</td>\'.PHP_EOL;\r\n		echo \'<td style=\"padding: 5px;\">\'.$text.\'</td>\'.PHP_EOL;\r\n		echo \'</tr>\'.PHP_EOL;\r\n	} \r\n\r\n\r\n    //  Wenn Bild eingefuegt wurde, Code schreiben \r\n    if (\"REX_FILE[1]\" != \"\") {\r\n\r\n	echo \'<tr>\'.PHP_EOL;		\r\n	echo \'<th colspan=\"2\"><br/><hr/><br/></th>\'.PHP_EOL;\r\n	echo \'</tr>\'.PHP_EOL;\r\n\r\n	$ausrichtung = \"\";\r\n    if (\"REX_VALUE[7]\" == \"l\") 		$ausrichtung = \"im Text links\";\r\n    if (\"REX_VALUE[7]\" == \"r\") 		$ausrichtung = \"im Text rechts\";\r\n    if (\"REX_VALUE[7]\" == \"tl\") 	$ausrichtung = \"links vom Text\";\r\n    if (\"REX_VALUE[7]\" == \"tr\") 	$ausrichtung = \"rechts vom Text\";\r\n	if (\"REX_VALUE[7]\" == \"tlu\") 	$ausrichtung = \"links von Text und Überschrift\";\r\n    if (\"REX_VALUE[7]\" == \"tru\") 	$ausrichtung = \"rechts von Text und Überschrift\";\r\n\r\n  	$bild 				= OOMedia::getMediaByName(\'REX_FILE[1]\');\r\n   	$bildTitle 			= $bild->getTitle();\r\n   	$bildBeschreibung 	= $bild->getValue(\'med_description\');\r\n    $bildCopyright 		= $bild->getValue(\'med_copyright\');\r\n   	$bildDateiName 		= $bild->getFileName();\r\n   	$bildBreite 		= $bild->getWidth();\r\n   	$bildHoehe 			= $bild->getHeight();\r\n\r\n   	if ($bildCopyright != \'\') {\r\n   		$bildCopyright = \" | (c) \".$bildCopyright;\r\n   	}\r\n\r\n	echo \'<tr>\'.PHP_EOL;\r\n	echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Bild</td>\'.PHP_EOL;\r\n	echo \'<td style=\"padding: 5px;\">REX_FILE[1]<br/><br/>\r\n			<img src=\"index.php?rex_img_type=rex_medialistbutton_preview&rex_img_file=\'.$bildDateiName.\'\" title=\"REX_VALUE[5]\'.$bildCopyright.\'\" alt=\"REX_VALUE[5]\'.$bildCopyright.\'\" />\r\n		  </td>\'.PHP_EOL;\r\n	echo \'</tr>\'.PHP_EOL;\r\n\r\n	echo \'<tr>\'.PHP_EOL;\r\n	echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Alternativtext</td>\'.PHP_EOL;\r\n	echo \'<td style=\"padding: 5px;\">REX_VALUE[5]\'.$bildCopyright.\'</td>\'.PHP_EOL;\r\n	echo \'</tr>\'.PHP_EOL;\r\n\r\n	$bildunterschrift = \'\';\r\n	  if(REX_IS_VALUE[6])\r\n		  {\r\n 			$bildunterschrift = htmlspecialchars_decode(\'REX_VALUE[6]\',ENT_QUOTES);\r\n			$bildunterschrift = str_replace(\'<br />\',\'\',$bildunterschrift);\r\n			$bildunterschrift = rex_a79_textile($bildunterschrift);\r\n\r\n			echo \'<tr>\'.PHP_EOL;\r\n			echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Bildunterschrift</td>\'.PHP_EOL;\r\n			echo \'<td style=\"padding: 5px;\">\'.$bildunterschrift.\'</td>\'.PHP_EOL;\r\n			echo \'</tr>\'.PHP_EOL;\r\n		   } \r\n\r\n	$bildgroesse = \"\";\r\n    if (\"REX_VALUE[8]\" == \"noresize\") 	$bildgroesse = \"keine Anpassung\";\r\n    if (\"REX_VALUE[8]\" == \"full\") 		$bildgroesse = \"ganze Breite\";\r\n    if (\"REX_VALUE[8]\" == \"half\") 		$bildgroesse = \"halbe Breite\";\r\n    if (\"REX_VALUE[8]\" == \"quarter\")	$bildgroesse = \"viertel Breite\";\r\n\r\n	echo \'<tr>\'.PHP_EOL;\r\n	echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Grösse</td>\'.PHP_EOL;\r\n	echo \'<td style=\"padding: 5px;\">\'.$bildgroesse.\'</td>\'.PHP_EOL;\r\n	echo \'</tr>\'.PHP_EOL;\r\n\r\n	echo \'<tr>\'.PHP_EOL;\r\n	echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Ausrichtung</td>\'.PHP_EOL;\r\n	echo \'<td style=\"padding: 5px;\">\'.$ausrichtung.\'</td>\'.PHP_EOL;\r\n	echo \'</tr>\'.PHP_EOL;\r\n\r\n	$bildrahmen = \"\";\r\n     if(REX_IS_VALUE[9]) {\r\n     	$bildrahmen = \"ja\";\r\n		echo \'<tr>\'.PHP_EOL;\r\n		echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Rahmen</td>\'.PHP_EOL;\r\n		echo \'<td style=\"padding: 5px;\">\'.$bildrahmen.\'</td>\'.PHP_EOL;\r\n		echo \'</tr>\'.PHP_EOL;\r\n     }\r\n\r\n\r\n	}\r\n\r\n    // Link\r\n    if (REX_IS_VALUE[10] OR REX_IS_VALUE[11] OR \"REX_LINK_ID[1]\" != 0 ) {\r\n\r\n		echo \'<tr>\'.PHP_EOL;		\r\n		echo \'<th colspan=\"2\"><br/><hr/><br/></th>\'.PHP_EOL;\r\n		echo \'</tr>\'.PHP_EOL;\r\n\r\n	    if(REX_IS_VALUE[11]) {\r\n\r\n	    	$externerlink = \"REX_VALUE[11]\";\r\n	    	if($externerlink != str_replace(\"http://\", \"\",$externerlink)) {\r\n				$externerlink = \"REX_VALUE[11]\";\r\n			} else {\r\n				$externerlink = \"http://REX_VALUE[11]\";\r\n			}\r\n\r\n			echo \'<tr>\'.PHP_EOL;\r\n			echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">externe URL</td>\'.PHP_EOL;\r\n			echo \'<td style=\"padding: 5px;\">\'.$externerlink.\'</td>\'.PHP_EOL;\r\n			echo \'</tr>\'.PHP_EOL;\r\n		}	\r\n\r\n	    if (\"REX_LINK_ID[1]\" != 0) {\r\n\r\n			echo \'<tr>\'.PHP_EOL;\r\n			echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">interner Link</td>\'.PHP_EOL;\r\n\r\n			$article=OOArticle::getArticleById(REX_LINK_ID[1]);\r\n			$name=$article->getName(); \r\n\r\n			echo \'<td style=\"padding: 5px;\"><a href=\"index.php?page=content&article_id=REX_LINK_ID[1]&mode=edit\">\'.$name.\'</a></td>\'.PHP_EOL;\r\n			echo \'</tr>\'.PHP_EOL;\r\n		}	\r\n\r\n		$verlinkungsart = \"\";\r\n    	if (\"REX_VALUE[13]\" == \"nurbildlink\") 				$verlinkungsart = \"nur das Bild ist verlinkt\";\r\n    	if (\"REX_VALUE[13]\" == \"ueberschriftlink\") 			$verlinkungsart = \"nur die Überschrift ist verlinkt\";\r\n    	if (\"REX_VALUE[13]\" == \"ueberschriftundbildlink\") 	$verlinkungsart = \"Überschrift und Bild sind verlinkt\";\r\n\r\n		echo \'<tr>\'.PHP_EOL;\r\n		echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Verlinkungsart</td>\'.PHP_EOL;\r\n		echo \'<td style=\"padding: 5px;\">\'.$verlinkungsart.\'</td>\'.PHP_EOL;\r\n		echo \'</tr>\'.PHP_EOL;\r\n\r\n	    if(REX_IS_VALUE[10]) {\r\n			echo \'<tr>\'.PHP_EOL;\r\n			echo \'<td style=\"padding: 5px; width: 100px; font-weight: bold;\">Linkbezeichnung</td>\'.PHP_EOL;\r\n			echo \'<td style=\"padding: 5px;\">REX_VALUE[10]</td>\'.PHP_EOL;\r\n			echo \'</tr>\'.PHP_EOL;\r\n		}	\r\n\r\n    }\r\n\r\n	echo \'</table>\'.PHP_EOL;\r\n\r\n}\r\n\r\n?>','<h1>Todo</h1>\r\n\r\n<ul>\r\n<li>Lightbox einbauen (http://dimsemenov.com/plugins/magnific-popup/)</li>\r\n<li>Youtube unterstützung einbauen? Mit Vorschaubild?</li>\r\n<li>Hilfe einbauen?</li>\r\n</ul>\r\n\r\n\r\n<div id=\"tabs\">\r\n	<ul>\r\n		<li><a href=\"#text\">Überschrift &amp; Text</a></li>\r\n		<li><a href=\"#bild\">Bild</a></li>\r\n		<li><a href=\"#link\">Link</a></li>\r\n		<li style=\"float:right;\"><a href=\"#weiteres\">Weitere Einstellungen</a></li>		\r\n	</ul>\r\n\r\n\r\n<?php\r\n\r\n\r\n// Rex Values\r\n//  1  : Überschrift\r\n//  2  : Überschrift-Tag\r\n//  3  : Inhaltstext\r\n// 	1  : Bild Datei -> REX_FILE[1]\r\n// 	5  : Alt Attribu \r\n// 	6  : Bildunterschrift\r\n// 	7  : Bild Ausrichtung\r\n// 	8  : Bild Größe\r\n// 	9  : Bild Rahmen\r\n// 10  : Link Bezeichnung\r\n// 11  : externe URL\r\n//  1  : interne URL -> REX_LINK_ID[1]\r\n// 13  : Verlinkungsart\r\n\r\n// 18,19,20 -> Online Einstellungen\r\n\r\nif (!isset($REX[\'base\'][\'textmodulcount\'])){ \r\n	$REX[\'base\'][\'textmodulcount\'] = 0;\r\n}\r\n$REX[\'base\'][\'textmodulcount\'] = $REX[\'base\'][\'textmodulcount\'] + 1;\r\n\r\n\r\n\r\n$objForm = new mform();\r\n\r\n// TEXT\r\n\r\n$objForm->addHtml(\'<div id=\"text\">\');\r\n\r\n$objForm->addHeadline(\'Überschrift\');\r\n\r\n\r\n// Mit Hilfe\r\n/*\r\n$objForm->addHeadline(\'Überschrift \r\n<div id=\"info_ueberschrift\" class=\"ui-state-default ui-corner-all\" title=\".ui-icon-help\" style=\"width: 17px; float: left; margin: -3px 10px 0 0; \">\r\n    <span class=\"ui-icon ui-icon-help\"></span>\r\n</div>\r\n	\');\r\n\r\n$objForm->addHtml(\'\r\n<div class=\"dialog\" id=\"dialog_ueberschrift\" title=\"Überschriften\" style=\"display:none;\">\r\n		<p>Lorem ipsum</p>\r\n</div>\r\n\');\r\n*/\r\n\r\n$objForm->addTextAreaField(1,array(\'label\'=>\'Text\',\'style\'=>\'width:500px\'));\r\n\r\n// Tag für Überschrift\r\n$tag = \'REX_VALUE[2]\';\r\nif ($tag == \'\' and $REX[\'base\'][\'textmodulcount\'] == 1) $tag = \'h1\';\r\nif ($tag == \'\') $tag = \'h2\';\r\n\r\n$objForm->addSelectField(2,array(\'h1\'=>\'H1\',\'h2\'=>\'H2\',\'h3\'=>\'H3\',\'h4\'=>\'H4\',\'h5\'=>\'H5\',\'h6\'=>\'H6\'),array(\'label\'=>\'Grösse\'),\'\',$tag);\r\n\r\n$objForm->addHtml(\'<br/>\');\r\n$objForm->addHeadline(\'Text\');\r\n$objForm->addTextAreaField(3,array(\'label\'=>\'Text eingeben\',\'class\'=>\"rex-markitup\",\'data-buttonset\'=>\"kreischer\",\'style\'=>\'width:500px !important;\'));\r\n$objForm->addHtml(\'</div>\');\r\n\r\n// BILD\r\n\r\n$objForm->addHtml(\'<div id=\"bild\">\');\r\n$objForm->addHeadline(\'Bild\');\r\n$objForm->addMediaField(1,array(\'types\'=>\'gif,jpg,png\',\'preview\'=>0,\'category\'=>0,\'label\'=>\'Datei\'));\r\n$objForm->addTextField(5,array(\'label\'=>\'Alternativtext\',\'style\'=>\'width:500px\'));\r\n\r\n$objForm->addHtml(\'<br/>\');\r\n$objForm->addHeadline(\'Weitere Eigenschaften\');\r\n$objForm->addTextAreaField(6,array(\'label\'=>\'Bildunterschrift\',\'style\'=>\'width:500px\'));\r\n\r\n\r\n$objForm->addSelectField(7, array(\r\n	\'l\'=>\'im Fliesstext links\',\r\n	\'r\'=>\'im Fliestext rechts\',\r\n	\'tl\'=>\'links vom Text\',\r\n	\'tr\'=>\'rechts vom Text\',\r\n	\'tlu\'=>\'links von Text und Überschrift\',\r\n	\'tru\'=>\'rechts von Text und Überschrift\'\r\n), array(\'label\'=>\'Ausrichtung\'));\r\n\r\n$objForm->addSelectField(8,array(\r\n	\'noresize\'=>\'keine Anpassung\',\r\n	\'full\'=>\'ganze Breite\',\r\n	\'half\'=>\'halbe Breite\',\r\n	\'quarter\'=>\'viertel Breite\'\r\n	),array(\'label\'=>\'Größe\'));\r\n\r\n$objForm->addCheckboxField(9,array(1=>\'\'),array(\'label\'=>\'Bildrahmen\'));\r\n\r\n$objForm->addHtml(\'</div>\');\r\n\r\n// LINK\r\n\r\n$objForm->addHtml(\'<div id=\"link\">\');\r\n$objForm->addHeadline(\'Link\');\r\n$objForm->addTextField(11,array(\'label\'=>\'extern\',\'style\'=>\'width:500px\'));\r\n$objForm->addLinkField(1,array(\'label\'=>\'intern\',\'category\'=>0));\r\n\r\n$objForm->addHtml(\'<br/>\');\r\n$objForm->addHeadline(\'Weitere Eigenschaften\');\r\n\r\n$objForm->addTextField(10,array(\'label\'=>\'Bezeichnung\',\'style\'=>\'width:500px\'));\r\n\r\n$objForm->addSelectField(13, array(\r\n	\'nurbildlink\'=>\'nur das Bild verlinken\',\r\n	\'ueberschriftlink\'=>\'nur Überschrift verlinken\',\r\n	\'ueberschriftundbildlink\'=>\'Überschrift und Bild verlinken\'\r\n), array(\'label\'=>\'Elemente\'));\r\n\r\n\r\n$objForm->addHtml(\'</div>\');\r\n\r\n// Weitere Einstellungen\r\n\r\n$objForm->addHtml(\'<div id=\"weiteres\">\');\r\n$objForm->addHeadline(\'Online Zeitraum einstellen\');\r\n$objForm->addCheckboxField(20,array(1=>\'\'),array(\'label\'=>\'Aktiv\'));\r\n$objForm->addTextField(19,array(\'label\'=>\'Online von\',\'style\'=>\'width:100px\',\'class\'=>\'datepicker1\'));\r\n$objForm->addTextField(18,array(\'label\'=>\'Online bis\',\'style\'=>\'width:100px\',\'class\'=>\'datepicker2\'));\r\n\r\n$objForm->addHtml(\'</div>\');\r\n\r\necho $objForm->show_mform();\r\n\r\n?>\r\n\r\n<script type=\"text/javascript\">\r\njQuery(\'#tabs\').tabs({\r\n	fx: { height: \'toggle\', duration: 200 },\r\n	select: function(event, ui) {\r\n		jQuery(this).css(\'height\', jQuery(this).height());\r\n	},\r\n//	show: function(event, ui) {\r\n//		jQuery(this).css(\'height\', \'550px\');\r\n//		jQuery(this).css(\'overflow\', \'visible\');\r\n//	}\r\n});\r\n\r\n\r\n\r\n	jQuery(document).ready(function($) {\r\n	\r\n// Hilfe Boxen\r\n// $(\'.dialog\').dialog({ autoOpen: false, width: 700});\r\n// $(\'#info_ueberschrift\').click(function(){  $(\'#dialog_ueberschrift\').dialog(\'open\');return false;});\r\n// $(\'#info_text\').click(function(){  $(\'#dialog_text\').dialog(\'open\');return false;});\r\n\r\n			$(\'#tabs\').tabs();\r\n\r\n			$(\".datepicker1\").datepicker({\r\n							inline: true,\r\n							dateFormat: \"dd.mm.yy\"\r\n							\r\n			});\r\n\r\n			$(\".datepicker2\").datepicker({\r\n							inline: true,\r\n				 			defaultDate: \"+1w\",\r\n							dateFormat: \"dd.mm.yy\"\r\n			});\r\n\r\n	});\r\n</script>','olien','olien',1377520122,1380609513,'',0),
  (10,'sdf',0,'<?php\r\n$templateid = \"REX_TEMPLATE_ID\";\r\n$ctypeid = \"REX_CTYPE_ID\";\r\n\r\nif (!isset($REX[\'mendocon\'][\'textmodulcount\'])){\r\n	$REX[\'mendocon\'][\'textmodulcount\'] = 0;\r\n}\r\n$REX[\'mendocon\'][\'textmodulcount\'] = $REX[\'mendocon\'][\'textmodulcount\'] + 1;\r\n\r\nif (!isset($REX[\'mendocon\'][\'contentrow\'])){\r\n	$REX[\'mendocon\'][\'contentrow\'] = 0;\r\n}\r\nif (isset($REX[\'mendocon\'][\'templateid\'])){\r\n	$templateid = $REX[\'mendocon\'][\'templateid\'];\r\n}\r\nif (isset($REX[\'mendocon\'][\'ctypeid\'])){\r\n	$ctypeid = $REX[\'mendocon\'][\'ctypeid\'];\r\n}\r\n\r\nif (OOAddon::isAvailable(\'textile\'))\r\n{\r\n	$ueberschrift = \'\';\r\n	$textile = \'\';\r\n	$file = \'\';\r\n	$tag = \'\';\r\n	$txclass = \'\';\r\n	\r\n	// Überschrift\r\n	if (REX_IS_VALUE[1])\r\n	{\r\n		$text = \"REX_VALUE[1]\";\r\n		if (\"REX_LINK_ID[2]\" != \'\') \r\n		{\r\n			$text = \'<a href=\"\'.rex_Geturl(\"REX_LINK_ID[2]\", $REX[\'CUR_CLANG\']).\'\">\'.$text.\'</a>\';\r\n		}\r\n		$tag = \"REX_VALUE[2]\";\r\n		if ($REX[\'REDAXO\']) \r\n		{ \r\n			$text = $text . \'&nbsp;<span>[\'.$tag.\']</span>\'; \r\n		}	\r\n		$ueberschrift = \"\\n\" . \'<\'.$tag.\'>\'.$text.\'</\'.$tag.\'>\';\r\n	}\r\n	\r\n	// Textile Text\r\n	if (REX_IS_VALUE[3])\r\n	{\r\n		$textile = htmlspecialchars_decode(\"REX_VALUE[3]\");\r\n		$textile = str_replace(\"<br />\", \"\", $textile);\r\n		$textile = rex_a79_textile($textile);\r\n	} \r\n	\r\n	//  Wenn Bild eingefuegt wurde, Code erzeugen \r\n	if (\"REX_FILE[1]\" != \'\') \r\n	{\r\n		$imsize = \"REX_VALUE[12]\";\r\n		\r\n		// Bild-Rahmen\r\n		$imclass = \'\';\r\n		if (\"REX_VALUE[10]\" == \"r\")\r\n		{\r\n			$imclass = \' class=\"borderimg\"\';\r\n		}\r\n		\r\n		// Klasse für figure\r\n		$fclass = \'\';\r\n		if (\"REX_VALUE[9]\" == \'u\')\r\n		{\r\n			$fclass = \'center bottom\';\r\n		}\r\n		if ((\"REX_VALUE[9]\" == \'o\') or (\"REX_VALUE[9]\" == \'uu\'))\r\n		{\r\n			$fclass = \'center\';\r\n		}\r\n		if ((\"REX_VALUE[9]\" == \'l\') or (\"REX_VALUE[9]\" == \'ol\') or (\"REX_VALUE[9]\" == \'ul\'))\r\n		{\r\n			$fclass = \'left\';\r\n		}\r\n		if ((\"REX_VALUE[9]\" == \'r\') or (\"REX_VALUE[9]\" == \'or\') or (\"REX_VALUE[9]\" == \'ur\'))\r\n		{\r\n			$fclass = \'right\';\r\n		}\r\n		if (\"REX_VALUE[9]\" == \'tl\')\r\n		{\r\n			$fclass = \'imgleft\';\r\n			$txclass = \' txright\';\r\n		}		\r\n		if (\"REX_VALUE[9]\" == \'tr\')\r\n		{\r\n			$fclass = \'imgright\';\r\n			$txclass = \' txleft\';\r\n		}	\r\n		\r\n		$file = \"\\n\" .\'	<figure class=\"\'.$fclass.\'\">\';\r\n\r\n		// Link auf Datei\r\n		if (\"REX_FILE[2]\" != \'\')\r\n		{\r\n			$file .= \"\\n\" . \'	<a class=\"openfile\" href=\"\'.$REX[\'HTDOCS_PATH\'] . \'files/REX_FILE[2]\">\';\r\n		}\r\n		// interner Link\r\n		else if (\"REX_LINK_ID[1]\" != \'\') \r\n		{\r\n			$file .= \"\\n\" . \'	<a href=\"\'.rex_Geturl(\"REX_LINK_ID[1]\", $REX[\'CUR_CLANG\']).\'\">\';\r\n		}\r\n		// externer Link\r\n		else if (\"REX_VALUE[11]\" != \"\") \r\n		{\r\n			$file .= \"\\n\" . \'	<a href=\"REX_VALUE[11]\">\';\r\n		}\r\n		// Bild in Fancybox öffnen\r\n		else if (\"REX_VALUE[5]\" == \"1\") \r\n		{\r\n			$file .= \"\\n\" . \'	<a class=\"fancybox\" href=\"\'.$REX[\'HTDOCS_PATH\'] . \'files/REX_FILE[1]\">\';\r\n		}\r\n			\r\n		// Bilddatei\r\n		if ($REX[\'REDAXO\'])\r\n		{\r\n			$file .= \"\\n\" . \'	<img src=\"index.php?rex_img_type=rex_mediapool_detail&amp;rex_img_file=REX_FILE[1]\" title=\"\'.\"REX_VALUE[7]\".\'\" alt=\"\'.\"REX_VALUE[7]\".\'\" \'.$imclass.\' />\';\r\n		}\r\n		else\r\n		{\r\n			if (\"REX_VALUE[14]\" <> \'\')\r\n			{\r\n					$file .= \"\\n\" . \'	<img src=\"files/REX_FILE[1]\" title=\"\'.\"REX_VALUE[7]\".\'\" alt=\"\'.\"REX_VALUE[7]\".\'\" \'.$imclass.\' />\';\r\n			}\r\n			else\r\n			{\r\n				if (($fclass == \'right\') or ($fclass == \'left\') or ($fclass == \'imgleft\') or ($fclass == \'imgright\'))\r\n				{\r\n					$file .= \"\\n\" . \'	<img src=\"index.php?rex_img_type=box_half_\'.$imsize.\'&amp;rex_img_file=REX_FILE[1]\" title=\"\'.\"REX_VALUE[7]\".\'\" alt=\"\'.\"REX_VALUE[7]\".\'\" \'.$imclass.\' />\';\r\n				}\r\n				else\r\n				{\r\n					$file .= \"\\n\" . \'	<img src=\"index.php?rex_img_type=box_full_\'.$imsize.\'&amp;rex_img_file=REX_FILE[1]\" title=\"\'.\"REX_VALUE[7]\".\'\" alt=\"\'.\"REX_VALUE[7]\".\'\" \'.$imclass.\' />\';\r\n				}\r\n			}	\r\n		}\r\n		\r\n		// evtl. Linkende\r\n		if ((\"REX_FILE[2]\" != \"\") or (\"REX_LINK[1]\" != \"\") or (\"REX_VALUE[11]\" != \"\") or (\"REX_VALUE[5]\" == \"1\"))\r\n		{\r\n			$file .= \"\\n\" . \'	</a>\';\r\n		}\r\n		\r\n		// Untertitel\r\n		if (\"REX_VALUE[8]\" <> \'\')\r\n		{\r\n			$file .= \"\\n\" . \'	<div class=\"subline\">REX_VALUE[8]</div>\';\r\n		}	\r\n		$file .= \"\\n\" . \'	</figure>\';\r\n	}\r\n  \r\n	// ----------------------------------------------------------------------------------------------\r\n	// Modulausgabe\r\n	// ----------------------------------------------------------------------------------------------\r\n	\r\n	if ((trim($ueberschrift)<>\'\') or (trim($file)<>\'\') or (trim($textile)<>\'\'))\r\n	{\r\n		\r\n		// Info im Backend ausgeben\r\n		if ($REX[\'REDAXO\'])\r\n		{\r\n			$bgcol = array(\'\'=>\'keine\', \'1\'=>\'hellgrau\', 2=>\'dunkelgrau\', 3=>\'blau\', 4=>\'gelb\', 5=>\'ohne, mit Rand\');\r\n			$infobr = \'\';\r\n			$infosi = \'\';\r\n			$infost = \'\';\r\n			if (\"REX_VALUE[4]\" == \'1\')\r\n			{ \r\n				$infobr = \' - Umbruch vor dem Inhalt \';\r\n			}\r\n			if (\"REX_VALUE[13]\" <> \'\') \r\n			{ \r\n				$infosi = \' - keine automatische Höhenanpassung \';\r\n			}\r\n			if (\"REX_VALUE[15]\" == \'1\') \r\n			{ \r\n				$infosi = \' - kleine Textgröße \';\r\n			}\r\n			if (\"REX_VALUE[16]\" == \'1\') \r\n			{ \r\n				$infosi = \' - große Textgröße \';\r\n			}				\r\n			echo \'<strong style=\"color:#090;\">Breite: REX_VALUE[12]%, Hintergrundfarbe: \'.$bgcol[\'REX_VALUE[6]\'].$infobr.$infosi.$infost.\'</strong>\';\r\n		}\r\n		\r\n		// Umbruch ausgeben\r\n		if (\"REX_VALUE[4]\" == \'1\')\r\n		{\r\n			$REX[\'mendocon\'][\'contentrow\'] = $REX[\'mendocon\'][\'contentrow\'] + 1;\r\n			echo \"\\n\" . \'<div class=\"clearfix\"></div>\';\r\n			$r = \' data-row=\"row\'.$REX[\'mendocon\'][\'contentrow\'].\'\" \';\r\n			echo \"\\n\" . \'<div class=\"spacing\"\'.$r.\'></div>\'.\"\\n\";\r\n		}\r\n		\r\n		// Breite Inhaltselement\r\n		$size = \'\';\r\n		if (\"REX_VALUE[12]\" <> \'\') \r\n		{\r\n			$size = \" contentREX_VALUE[12] \";\r\n		}\r\n\r\n		// Hintergrundfarbe\r\n		$box = \'\';\r\n		if (\"REX_VALUE[6]\" <> \'\') \r\n		{\r\n			$box = \" colorboxREX_VALUE[6] \";\r\n		}\r\n		\r\n		// No resize\r\n		$noresize = \'\';\r\n		if (\"REX_VALUE[13]\" <> \'\') \r\n		{\r\n			$noresize = \" noresize \";\r\n		}	\r\n		\r\n		// kleiner Text\r\n		$smalltext = \'\';\r\n		if (\"REX_VALUE[15]\" == \'1\')\r\n		{\r\n			$smalltext = \" smalltext \";\r\n		}\r\n	\r\n		// großer Text\r\n		$bigtext = \'\';\r\n		if (\"REX_VALUE[16]\" == \'1\')\r\n		{\r\n			$bigtext = \" bigtext \";\r\n		}\r\n		\r\n		// Ausgabe Wrapper\r\n		echo \"\\n\" . \'<div class=\"textile textile-\'.$tag.$size.$box.$noresize.$smalltext.$bigtext.\' row\'.$REX[\'mendocon\'][\'contentrow\'].\'\">\';\r\n\r\n		// Ausgabe Image\r\n		if (\"REX_VALUE[9]\" == \'uu\')\r\n		{\r\n			echo $file;\r\n		}	\r\n		\r\n		// Ausgabe der Überschrift\r\n		if ($ueberschrift <> \'\')\r\n		{\r\n			echo $ueberschrift;\r\n		}\r\n\r\n		// Ausgabe Image\r\n		if ((\"REX_VALUE[9]\" == \'o\') or (\"REX_VALUE[9]\" == \'or\') or (\"REX_VALUE[9]\" == \'ol\'))\r\n		{\r\n			echo $file;\r\n		}\r\n\r\n		// Ausgabe Text\r\n		if ((trim($file)<>\'\') or (trim($textile)<>\'\'))\r\n		{\r\n			if (\"REX_VALUE[9]\" == \'tl\')\r\n			{\r\n				echo $file;\r\n			}\r\n			echo \"\\n\" . \'<div class=\"text text-\'.$tag.$txclass.\'\">\';\r\n			if ((\"REX_VALUE[9]\" == \'l\') or (\"REX_VALUE[9]\" == \'r\'))\r\n			{\r\n				echo $file;\r\n			}\r\n			echo \"\\n\" . trim($textile);\r\n			echo \"\\n\" . \'</div>\';\r\n			if (\"REX_VALUE[9]\" == \'tr\')\r\n			{\r\n				echo $file;\r\n			}\r\n			echo \"\\n\" . \'<div class=\"clearfix\"></div>\' . \"\\n\";\r\n		}\r\n			\r\n		// Ausgabe Image\r\n		if ((\"REX_VALUE[9]\" == \'u\') or (\"REX_VALUE[9]\" == \'ur\') or (\"REX_VALUE[9]\" == \'ul\'))\r\n		{\r\n			echo $file;\r\n		}\r\n		echo \"\\n\" . \'</div>\' . \"\\n\";\r\n	}\r\n}	\r\nelse\r\n{\r\n  echo rex_warning(\'Dieses Modul benötigt das \"textile\" Addon!\');\r\n}\r\n\r\n//echo \"<br>Text: template id = $templateid ctype id = $ctypeid\";\r\n?>','<?php\r\n// Rex Values\r\n//  1  : Überschrift\r\n//  2  : Überschrift-Tag\r\n//  3  : Inhaltstext\r\n//  4  : Umbruch einfügen\r\n//  5  : Lightbox anzeige\r\n//  6  : Hintergrundfarbe\r\n//  7  : Bildtitel\r\n//  8  : Bildunterschrift\r\n//  9  : Bildausrichtung\r\n//  10 : Bildrahmen\r\n//  11 : externer Link\r\n//  12 : Breite Texblock\r\n//  13 : autom. Höhe unterdrücken\r\n//  14 : kein imageresize\r\n//  15 : kleine Textgröße\r\n//  16 : grosse Textgröße\r\n\r\n\r\nif (!isset($REX[\'base\'][\'textmodulcount\'])){\r\n	$REX[\'base\'][\'textmodulcount\'] = 0;\r\n}\r\n$REX[\'base\'][\'textmodulcount\'] = $REX[\'base\'][\'textmodulcount\'] + 1;\r\n\r\nif(OOAddon::isAvailable(\'markitup\'))\r\n{\r\n  a287_markitup::markitup(\'textarea.markitup1\');\r\n}\r\n\r\n$objForm = new mform();\r\n\r\n// - headline --------------------------------------------------------------------------------------\r\n$objForm->addHeadline(\'Textinhalt\');\r\n\r\n// Überschrift\r\n$objForm->addTextAreaField(1, array(\'label\'=>\'&Uuml;berschrift\', \'style\'=>\'width:500px\'));\r\n\r\n// Tag für Überschrift\r\n$tag = \'REX_VALUE[2]\';\r\nif ($tag == \'\' and $REX[\'base\'][\'textmodulcount\'] == 1) $tag = \'h1\';\r\nif ($tag == \'\') $tag = \'h2\';\r\n$objForm->addSelectField(2, $tag, array(\'h1\'=>\'H1\', \'h2\'=>\'H2\', \'h3\'=>\'H3\', \'h4\'=>\'H4\', \'h5\'=>\'H5\', \'h6\'=>\'H6\'), array(\'label\'=>\'&Uuml;berschrift-Tag\'));\r\n\r\n// Titel intern verlinken\r\n$objForm->addLinkField(2, \'REX_LINK_ID[2]\', array(\'label\'=>\'Interner Link\', \'category\'=>0));\r\n\r\n// Markitup Text\r\n$objForm->addTextAreaField(3, \'REX_VALUE[3]\', array(\'label\'=>\'Text\',\'style\'=>\'width:500px;height:250px\', \'class\'=>\"markitup1\"));\r\n\r\n// kleine Textgröße\r\n$objForm->addCheckboxField(15, \'REX_VALUE[15]\', array(1=>\'kleine Textgröße\'), array(\'label\'=>\'\'));\r\n\r\n// große Textgröße\r\n$objForm->addCheckboxField(16, \'REX_VALUE[16]\', array(1=>\'große Textgröße\'), array(\'label\'=>\'\'));\r\n\r\n// - headline --------------------------------------------------------------------------------------\r\n$objForm->addHeadline(\'Darstellung des Inhalts\');\r\n\r\n// Breite des Textblocks\r\n$size = \'REX_VALUE[12]\';\r\nif ($size == \'\') $size = \'50\';\r\n$objForm->addSelectField(12, $size, array(\'25\'=>\'25%\', \'50\'=>\'50%\', \'75\'=>\'75%\', \'100\'=>\'100%\'), array(\'label\'=>\'Breite Inhaltsblock\'));\r\n\r\n// Hintergrundfarbe\r\n$objForm->addSelectField(6, \'REX_VALUE[6]\', array(\'\'=>\'ohne\', \'1\'=>\'hellgrau\', \'2\'=>\'dunkelgrau\', \'3\'=>\'blau\', \'4\'=>\'gelb\', \'5\'=>\'ohne, mit Rand\'), array(\'label\'=>\'Hintergrund\'));\r\n\r\n// neue Zeile Umbruch einfügen (clear both)\r\n$objForm->addCheckboxField(4, \'REX_VALUE[4]\', array(1=>\'Umbruch vor diesem Inhaltsblock\'), array(\'label\'=>\'\'));\r\n\r\n// Auto Height unterdrücken\r\n$objForm->addCheckboxField(13, \'REX_VALUE[13]\', array(1=>\'keine automatische Höhenanpassung\'), array(\'label\'=>\'\'));\r\n\r\n// - headline --------------------------------------------------------------------------------------\r\n$objForm->addHeadline(\'Bildauswahl\');\r\n\r\n// Bild\r\n$objForm->addMediaField(1, \'REX_FILE[1]\', array(\'types\'=>\'gif,jpg,png\', \'preview\'=>1, \'category\'=>0, \'label\'=>\'Bild\'));\r\n\r\n// Bildtitel / Bildunterschrift\r\n$objForm->addTextField(7, \'REX_VALUE[7]\', array(\'label\'=>\'Bildtitel\', \'style\'=>\'width:500px\'));\r\n$objForm->addTextField(8, \'REX_VALUE[8]\', array(\'label\'=>\'Bildunterschrift\', \'style\'=>\'width:500px\'));\r\n\r\n// Ausrichtung des Bildes\r\n$objForm->addSelectField(9, \'REX_VALUE[9]\', array(\r\n	\'l\'=>\'im Text links\', \r\n	\'r\'=>\'im Text rechts\', \r\n	\'o\'=>\'über dem Text zentriert\', \r\n	\'ol\'=>\'über dem Text links\', \r\n	\'or\'=>\'über dem Text rechts\', \r\n	\'u\'=>\'unter dem Text zentriert\', \r\n	\'ul\'=>\'unter dem Text links\',\r\n	\'ur\'=>\'unter dem Text rechts\',\r\n	\'tl\'=>\'links vom Text\',\r\n	\'tr\'=>\'rechts vom Text\',\r\n	\'uu\'=>\'über der Überschrift\'\r\n	), array(\'label\'=>\'Ausrichtung\'));\r\n\r\n// Rahmen für das Bild?\r\n$objForm->addSelectField(10, \'REX_VALUE[10]\', array(\r\n	\'o\'=>\'ohne Rahmen\', \r\n	\'r\'=>\'mit Rahmen\'\r\n	), array(\'label\'=>\'Rahmen\'));\r\n\r\n// Lightbox\r\n$objForm->addCheckboxField(5, \'REX_VALUE[5]\', array(1=>\'Bild in der Lightbox anzeigen\'), array(\'label\'=>\'\'));\r\n\r\n// ImageResize unterdrücken\r\n$objForm->addCheckboxField(14, \'REX_VALUE[14]\', array(1=>\'Bildgr&ouml;&szlig;e nicht anpassen\'), array(\'label\'=>\'\'));\r\n	\r\n// - headline --------------------------------------------------------------------------------------\r\n$objForm->addHeadline(\'Bildverlinkung\');\r\n\r\n// Dateilink \'types\'=>\'\', \r\n$objForm->addMediaField(2, \'REX_FILE[2]\', array(\'preview\'=>0, \'category\'=>0, \'label\'=>\'Dateilink\'));\r\n\r\n// Interner Link\r\n$objForm->addLinkField(1, \'REX_LINK_ID[1]\', array(\'label\'=>\'Interner Link\', \'category\'=>0));\r\n\r\n// externer Link\r\n$objForm->addTextField(11, \'REX_VALUE[11]\', array(\'label\'=>\'Externer Link\', \'style\'=>\'width:500px\'));\r\n\r\n// get formular\r\necho $objForm->show_mform();\r\n?>','olien','olien',1377611056,1377688453,'',0);
/*!40000 ALTER TABLE `rex_module` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_module_action`;
CREATE TABLE `rex_module_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `action_id` int(11) NOT NULL,
  `revision` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_redirects`;
CREATE TABLE `rex_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_url` varchar(255) NOT NULL,
  `target_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_responsiveimg`;
CREATE TABLE `rex_responsiveimg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile_first` varchar(255) NOT NULL,
  `minwidth` int(11) NOT NULL,
  `responsive` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_responsiveimg` WRITE;
/*!40000 ALTER TABLE `rex_responsiveimg` DISABLE KEYS */;
INSERT INTO `rex_responsiveimg` VALUES 
  (3,'contentimage_quarter',800,'contentimage_full');
/*!40000 ALTER TABLE `rex_responsiveimg` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_template`;
CREATE TABLE `rex_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `content` text,
  `active` tinyint(1) DEFAULT NULL,
  `createuser` varchar(255) NOT NULL,
  `updateuser` varchar(255) NOT NULL,
  `createdate` int(11) NOT NULL,
  `updatedate` int(11) NOT NULL,
  `attributes` text,
  `revision` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `rex_template` WRITE;
/*!40000 ALTER TABLE `rex_template` DISABLE KEYS */;
INSERT INTO `rex_template` VALUES 
  (1,'','Standard','<?php\r\nheader(\'Content-Type: text/html; charset=utf-8\');\r\n\r\n  error_reporting(E_ALL); // error_reporting(0);\r\n  \r\n\r\n/* Artikel/Kategorie online? Wenn nein dann auf die Startseite */\r\n\r\nif(!isset($_SESSION)) { session_start(); }\r\n\r\n if (!isset($_SESSION[$REX[\'INSTNAME\']][\'UID\'])) // aber nur wenn nicht im Backend angemeldet\r\n { if ($this->getValue(\'status\') == 0)\r\n   { if ($this->getValue(\'startpage\') == 0)\r\n     {  // Weiterleitung für Artikel\r\n      header(\'Location: \' . $REX[\'SERVER\']);\r\n      exit;\r\n     }\r\n    else\r\n   {\r\n    // Weiterleitung für Kategorien\r\n    header(\'Location: \' . $REX[\'SERVER\']);\r\n    exit;\r\n   }\r\n  }\r\n }\r\n\r\n/*     RexSEO */\r\nif(OOAddon::isAvailable(\'rexseo\'))\r\n{\r\n  $meta = new rexseo_meta();\r\n  $meta_description   = $meta->get_description();\r\n  $meta_keywords      = $meta->get_keywords();\r\n  $meta_title         = $meta->get_title();\r\n  $meta_canonical     = $meta->get_canonical();\r\n  $meta_base          = $meta->get_base();\r\n}\r\nelse\r\n{\r\n  $OOStartArticle     = OOArticle::getArticleById($REX[\'START_ARTICLE_ID\'], $REX[\'CUR_CLANG\']);\r\n  $meta_description   = $OOStartArticle->getValue(\"art_description\");\r\n  $meta_keywords      = $OOStartArticle->getValue(\"art_keywords\");\r\n\r\n  if($this->getValue(\"art_description\") != \"\")\r\n    $meta_description = htmlspecialchars($this->getValue(\"art_description\"));\r\n  if($this->getValue(\"art_keywords\") != \"\")\r\n    $meta_keywords    = htmlspecialchars($this->getValue(\"art_keywords\"));\r\n\r\n  $meta_title         = $REX[\'SERVERNAME\'].\' | \'.$this->getValue(\"name\");\r\n  $meta_canonical     = isset($_REQUEST[\'REQUEST_URI\']) ? $_REQUEST[\'REQUEST_URI\'] : \'\';\r\n  $meta_base          = \'http://\'.$_SERVER[\'HTTP_HOST\'].\'/\';\r\n}\r\n\r\n  \r\n?>\r\n<!DOCTYPE html>\r\n<html lang=\"de\">\r\n<head>\r\n  <base href=\"<?php echo $meta_base; ?>\" />\r\n  <title><?php echo $meta_title; ?></title>\r\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n  <meta name=\"language\" content=\"deutsch, de\" />\r\n  <meta name=\"keywords\" content=\"<?php echo $meta_keywords; ?>\" />\r\n  <meta name=\"description\" content=\"<?php echo $meta_description; ?>\" />\r\n  \r\n  <link rel=\"canonical\" href=\"<?php echo $meta_canonical; ?>\" />\r\n\r\n  <link rel=\"shortcut icon\" href=\"assets/img/icons/favicon.ico\">\r\n  <link rel=\"apple-touch-icon-precomposed\" sizes=\"144x144\" href=\"assets/img/icons/apple-touch-icon-144x144-precomposed.png\">\r\n  <link rel=\"apple-touch-icon-precomposed\" sizes=\"114x114\" href=\"assets/img/icons/apple-touch-icon-114x114-precomposed.png\">\r\n  <link rel=\"apple-touch-icon-precomposed\" sizes=\"72x72\" href=\"assets/img/icons/apple-touch-icon-72x72-precomposed.png\">\r\n  <link rel=\"apple-touch-icon-precomposed\" href=\"assets/img/icons/apple-touch-icon-57x57-precomposed.png\">\r\n  \r\n  \r\n  <meta name=\"MSSmartTagsPreventParsing\" content=\"no\" >\r\n  <meta name=\"robots\" content=\"index, follow\">\r\n  <meta http-equiv=\"cleartype\" content=\"on\">\r\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\" />\r\n  <!-- http://t.co/dKP3o1e -->\r\n  <meta name=\"HandheldFriendly\" content=\"True\">\r\n  <meta name=\"MobileOptimized\" content=\"320\">\r\n  <meta name=\"viewport\" content=\"width=device-width, target-densitydpi=160dpi, initial-scale=1.0\">\r\n  <!-- Facebook -->\r\n  <meta content=\"de_DE\" />\r\n  <meta content=\"article\" />\r\n  <meta content=\"Social Meta-Tags in WordPress – Allgemein -\" />\r\n  <meta content=\"Das ist die Facebook-Beschreibung des Artikels über Social Meta-Tags.\" />\r\n  <meta content=\"SEO Book\" />\r\n  <meta content=\"assets/img/icons/facebook_twitter-590x434.png\" />\r\n  <!-- Twitter -->\r\n  <meta name=\"twitter:card\" content=\"summary\" />\r\n  <meta name=\"twitter:site\" content=\"@eric108\" />\r\n  <meta name=\"twitter:domain\" content=\"SEO Book\" />\r\n  <meta name=\"twitter:creator\" content=\"@vanseo\" />\r\n  <meta name=\"twitter:image:src\" content=\"assets/img/icons/facebook_twitter-590x434.png\" />\r\n  <!-- http://www.geo-tag.de/generator/en.html -->\r\n  <meta name=\"geo.placename\" content=\"\" />\r\n  <meta name=\"geo.position\" content=\"\" />\r\n  <meta name=\"geo.region\" content=\"\" />\r\n  <meta name=\"ICBM\" content=\"\" />\r\n \r\n  <link rel=\"stylesheet\" href=\"assets/css/screen.min.cc.css\" media=\"screen, print\">\r\n  <link rel=\"stylesheet\" href=\"assets/css/responsive.min.cc.css\" media=\"screen\">\r\n  <link rel=\"stylesheet\" href=\"assets/css/print.min.cc.css\" media=\"print\">\r\n  <!--[if IE]><![endif]-->\r\n  <script src=\"assets/js/vendor/jquery.1.9.1.min.js\"></script>\r\n  <script src=\"assets/js/vendor/modernizr.2.6.2.min.js\"></script>\r\n  </head>\r\n<?php if ($REX[\'START_ARTICLE_ID\'] == $this->getValue(\"article_id\")) {\r\necho \'<body id=\"home\">\'.PHP_EOL;\r\n} else {\r\necho \'<body>\'.PHP_EOL;\r\n}?>\r\n<!--[if lt IE 7]>\r\n<div class=\"iehinweis\"><p class=\"chromeframe\">You are using an <strong>outdated</strong> browser. Please <a href=\"http://browsehappy.com/\">upgrade your browser</a>.</p> </div>\r\n<![endif]-->\r\n\r\n<a href=\"top\"></a>\r\n\r\nREX_ARTICLE[]\r\n\r\n\r\n<script src=\"assets/js/vendor/jquery.easing.1.3.min.js\"></script>\r\n<script src=\"assets/js/domscript.js\"></script>\r\n\r\n</body>\r\n</html>',1,'olien','olien',1377524572,1380608975,'a:3:{s:10:\"categories\";a:1:{s:3:\"all\";s:1:\"1\";}s:5:\"ctype\";a:0:{}s:7:\"modules\";a:1:{i:1;a:1:{s:3:\"all\";s:1:\"1\";}}}',0),
  (2,'','Wartungsarbeiten','<!DOCTYPE html>\r\n<html lang=\"de\">\r\n  <head>\r\n    <meta charset=\"utf-8\" />\r\n    <title><?php $REX[\'SERVERNAME\'].\' | \'.$this->getValue(\"name\"); ?></title>\r\n \r\n<link href=\'http://fonts.googleapis.com/css?family=Didact+Gothic|PT+Serif&amp;v2\' rel=\'stylesheet\' type=\'text/css\'>\r\n\r\n <style type=\"text/css\">\r\n\r\n	* {margin: 0; padding: 0;}\r\n	\r\n    body {\r\n    size:12px;\r\n	color: #555;\r\n	background: #e6e6e6;\r\n	}\r\n	\r\n	#content{\r\n		margin: 20px 0 0 20px;\r\n	}\r\n	\r\n	h1 {\r\n	font-family: \'Didact Gothic\', sans-serif;\r\n	font-style: normal;\r\n	font-weight: 400;\r\n	font-size: 30px;\r\n	text-transform: none;\r\n	text-decoration: none;\r\n	letter-spacing: 0em;\r\n	word-spacing: 0em;\r\n	line-height: 1.4;\r\n	}\r\n\r\n	p {\r\n	font-family: \'PT Serif\', serif;\r\n	font-style: normal;\r\n	font-weight: 400;\r\n	font-size: 14px;\r\n	text-transform: none;\r\n	text-decoration: none;\r\n	letter-spacing: 0.025em;\r\n	word-spacing: 0em;\r\n	line-height: 1.4;\r\n	}\r\n	\r\n</style>\r\n\r\n  </head>\r\n  <body>\r\n	<div id=\"content\">	\r\n	REX_ARTICLE[]\r\n	</div>\r\n  </body>\r\n</html>',1,'olien','olien',1365071643,1373497720,'a:3:{s:10:\"categories\";a:1:{s:3:\"all\";s:1:\"1\";}s:5:\"ctype\";a:0:{}s:7:\"modules\";a:1:{i:1;a:1:{s:3:\"all\";s:1:\"1\";}}}',0);
/*!40000 ALTER TABLE `rex_template` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rex_xform_email_template`;
CREATE TABLE `rex_xform_email_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `mail_from` varchar(255) NOT NULL DEFAULT '',
  `mail_from_name` varchar(255) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `body_html` text NOT NULL,
  `attachments` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_xform_field`;
CREATE TABLE `rex_xform_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL,
  `prio` int(11) NOT NULL,
  `type_id` varchar(100) NOT NULL,
  `type_name` varchar(100) NOT NULL,
  `f1` text NOT NULL,
  `f2` text NOT NULL,
  `f3` text NOT NULL,
  `f4` text NOT NULL,
  `f5` text NOT NULL,
  `f6` text NOT NULL,
  `f7` text NOT NULL,
  `f8` text NOT NULL,
  `f9` text NOT NULL,
  `list_hidden` tinyint(4) NOT NULL,
  `search` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_xform_relation`;
CREATE TABLE `rex_xform_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_table` varchar(100) NOT NULL,
  `source_name` varchar(100) NOT NULL,
  `source_id` int(11) NOT NULL,
  `target_table` varchar(100) NOT NULL,
  `target_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `rex_xform_table`;
CREATE TABLE `rex_xform_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `list_amount` tinyint(3) unsigned NOT NULL DEFAULT '50',
  `prio` int(11) NOT NULL,
  `search` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `export` tinyint(4) NOT NULL,
  `import` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_name` (`table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
