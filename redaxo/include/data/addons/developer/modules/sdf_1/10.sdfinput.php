<?php
// Rex Values
//  1  : Überschrift
//  2  : Überschrift-Tag
//  3  : Inhaltstext
//  4  : Umbruch einfügen
//  5  : Lightbox anzeige
//  6  : Hintergrundfarbe
//  7  : Bildtitel
//  8  : Bildunterschrift
//  9  : Bildausrichtung
//  10 : Bildrahmen
//  11 : externer Link
//  12 : Breite Texblock
//  13 : autom. Höhe unterdrücken
//  14 : kein imageresize
//  15 : kleine Textgröße
//  16 : grosse Textgröße


if (!isset($REX['base']['textmodulcount'])){
	$REX['base']['textmodulcount'] = 0;
}
$REX['base']['textmodulcount'] = $REX['base']['textmodulcount'] + 1;

if(OOAddon::isAvailable('markitup'))
{
  a287_markitup::markitup('textarea.markitup1');
}

$objForm = new mform();

// - headline --------------------------------------------------------------------------------------
$objForm->addHeadline('Textinhalt');

// Überschrift
$objForm->addTextAreaField(1, array('label'=>'&Uuml;berschrift', 'style'=>'width:500px'));

// Tag für Überschrift
$tag = 'REX_VALUE[2]';
if ($tag == '' and $REX['base']['textmodulcount'] == 1) $tag = 'h1';
if ($tag == '') $tag = 'h2';
$objForm->addSelectField(2, $tag, array('h1'=>'H1', 'h2'=>'H2', 'h3'=>'H3', 'h4'=>'H4', 'h5'=>'H5', 'h6'=>'H6'), array('label'=>'&Uuml;berschrift-Tag'));

// Titel intern verlinken
$objForm->addLinkField(2, 'REX_LINK_ID[2]', array('label'=>'Interner Link', 'category'=>0));

// Markitup Text
$objForm->addTextAreaField(3, 'REX_VALUE[3]', array('label'=>'Text','style'=>'width:500px;height:250px', 'class'=>"markitup1"));

// kleine Textgröße
$objForm->addCheckboxField(15, 'REX_VALUE[15]', array(1=>'kleine Textgröße'), array('label'=>''));

// große Textgröße
$objForm->addCheckboxField(16, 'REX_VALUE[16]', array(1=>'große Textgröße'), array('label'=>''));

// - headline --------------------------------------------------------------------------------------
$objForm->addHeadline('Darstellung des Inhalts');

// Breite des Textblocks
$size = 'REX_VALUE[12]';
if ($size == '') $size = '50';
$objForm->addSelectField(12, $size, array('25'=>'25%', '50'=>'50%', '75'=>'75%', '100'=>'100%'), array('label'=>'Breite Inhaltsblock'));

// Hintergrundfarbe
$objForm->addSelectField(6, 'REX_VALUE[6]', array(''=>'ohne', '1'=>'hellgrau', '2'=>'dunkelgrau', '3'=>'blau', '4'=>'gelb', '5'=>'ohne, mit Rand'), array('label'=>'Hintergrund'));

// neue Zeile Umbruch einfügen (clear both)
$objForm->addCheckboxField(4, 'REX_VALUE[4]', array(1=>'Umbruch vor diesem Inhaltsblock'), array('label'=>''));

// Auto Height unterdrücken
$objForm->addCheckboxField(13, 'REX_VALUE[13]', array(1=>'keine automatische Höhenanpassung'), array('label'=>''));

// - headline --------------------------------------------------------------------------------------
$objForm->addHeadline('Bildauswahl');

// Bild
$objForm->addMediaField(1, 'REX_FILE[1]', array('types'=>'gif,jpg,png', 'preview'=>1, 'category'=>0, 'label'=>'Bild'));

// Bildtitel / Bildunterschrift
$objForm->addTextField(7, 'REX_VALUE[7]', array('label'=>'Bildtitel', 'style'=>'width:500px'));
$objForm->addTextField(8, 'REX_VALUE[8]', array('label'=>'Bildunterschrift', 'style'=>'width:500px'));

// Ausrichtung des Bildes
$objForm->addSelectField(9, 'REX_VALUE[9]', array(
	'l'=>'im Text links', 
	'r'=>'im Text rechts', 
	'o'=>'über dem Text zentriert', 
	'ol'=>'über dem Text links', 
	'or'=>'über dem Text rechts', 
	'u'=>'unter dem Text zentriert', 
	'ul'=>'unter dem Text links',
	'ur'=>'unter dem Text rechts',
	'tl'=>'links vom Text',
	'tr'=>'rechts vom Text',
	'uu'=>'über der Überschrift'
	), array('label'=>'Ausrichtung'));

// Rahmen für das Bild?
$objForm->addSelectField(10, 'REX_VALUE[10]', array(
	'o'=>'ohne Rahmen', 
	'r'=>'mit Rahmen'
	), array('label'=>'Rahmen'));

// Lightbox
$objForm->addCheckboxField(5, 'REX_VALUE[5]', array(1=>'Bild in der Lightbox anzeigen'), array('label'=>''));

// ImageResize unterdrücken
$objForm->addCheckboxField(14, 'REX_VALUE[14]', array(1=>'Bildgr&ouml;&szlig;e nicht anpassen'), array('label'=>''));
	
// - headline --------------------------------------------------------------------------------------
$objForm->addHeadline('Bildverlinkung');

// Dateilink 'types'=>'', 
$objForm->addMediaField(2, 'REX_FILE[2]', array('preview'=>0, 'category'=>0, 'label'=>'Dateilink'));

// Interner Link
$objForm->addLinkField(1, 'REX_LINK_ID[1]', array('label'=>'Interner Link', 'category'=>0));

// externer Link
$objForm->addTextField(11, 'REX_VALUE[11]', array('label'=>'Externer Link', 'style'=>'width:500px'));

// get formular
echo $objForm->show_mform();
?>