<?php

if(!$REX['REDAXO']) {

echo'
<div class="zweispalter">
 <div class="zweispalter_links">
'; 
 
if(OOAddon::isAvailable('textile'))
	{
	  echo '<div class="textbild">'."\r\n";
	  //  Ausrichtung des Bildes 
	  if ("REX_VALUE[4]" == "left") $float = "floatLeft";
	  if ("REX_VALUE[4]" == "right") $float = "floatRight";
			
	  //  Wenn Bild eingefuegt wurde, Code schreiben 
	  $file = "";
	  if ("REX_FILE[1]" != "") {
	  	$file = '<div class="'.$float.'">
		 <img src="index.php?rex_img_type=rex_mediabutton_preview&rex_img_file=REX_FILE[1]" title="'."REX_VALUE[2]".'" alt="'."REX_VALUE[2]".'" />
		 <span class="subline">REX_VALUE[3]</span>
		</div>'."\r\n";
	  	}
			
	  $textile = '';
		  if(REX_IS_VALUE[1])
		  {
		    $textile = htmlspecialchars_decode("REX_VALUE[1]");
		    $textile = str_replace("<br />","",$textile);
		    $textile = rex_a79_textile($textile);
		    $textile = str_replace("###","&#x20;",$textile);
		  } 
		  print $file.$textile."\r\n";
			
		  echo '</div>'."\r\n";
		  echo '<div class="clboth"></div>'."\r\n";

} else {
  echo rex_warning('Dieses Modul benötigt das "textile" Addon!');
} 
 
 
echo '
 </div>
 <div class="zweispalter_rechts">
';
 
 
if(OOAddon::isAvailable('textile'))
	{
	  echo '<div class="textbild">'."\r\n";
	  //  Ausrichtung des Bildes 
	  if ("REX_VALUE[9]" == "left") $float = "floatLeft";
	  if ("REX_VALUE[9]" == "right") $float = "floatRight";
			
	  //  Wenn Bild eingefuegt wurde, Code schreiben 
	  $file = "";
	  if ("REX_FILE[6]" != "") {
	  	$file = '<div class="'.$float.'">
		 <img src="index.php?rex_img_type=rex_mediabutton_preview&rex_img_file=REX_FILE[6]" title="'."REX_VALUE[7]".'" alt="'."REX_VALUE[7]".'" />
		 <span class="subline">REX_VALUE[8]</span>
		</div>'."\r\n";
	  	}
			
	  $textile2 = '';
		  if(REX_IS_VALUE[5])
		  {
		    $textile2 = htmlspecialchars_decode("REX_VALUE[5]");
		    $textile2 = str_replace("<br />","",$textile2);
		    $textile2 = rex_a79_textile($textile2);
		    $textile2 = str_replace("###","&#x20;",$textile2);
		  } 
		  print $file.$textile2."\r\n";
			
		  echo '</div>'."\r\n";
		  echo '<div class="clboth"></div>'."\r\n";

} else {
  echo rex_warning('Dieses Modul benötigt das "textile" Addon!');
}  
 
 
echo '
 </div>
 <span class="clboth">&nbsp;</span>
</div>
';



} else {

	echo '<strong>Links</strong>'."\r\n";
	echo '<br/>'."\r\n";	
	echo '<br/>'."\r\n";		
	echo '<b>Text:</b> REX_VALUE[1]';
	echo '<br/>';

    if ("REX_VALUE[4]" == "left") $ausrichtung = "links vom Text";
    if ("REX_VALUE[4]" == "right") $ausrichtung = "links vom Text";
			
    //  Wenn Bild eingefuegt wurde, Code schreiben 
    if ("REX_FILE[1]" != "") {
	echo '<br/>'."\r\n";		  
    echo '<b>Dateiname:</b> REX_FILE[1]'."\r\n";
	echo '<br/>'."\r\n";
	echo '<b>Titel:</b> REX_VALUE[2]'."\r\n";			  
	echo '<br/>'."\r\n";
	echo '<b>Bildunterschrift:</b> REX_VALUE[3]'."\r\n";
	echo '<br/>'."\r\n";
	echo '<b>Ausrichtung:</b> '.$ausrichtung."\r\n";	
	echo '<br/>'."\r\n";
    echo '<b>Bild:</b>'."\r\n";
	echo '<br/>'."\r\n";
	echo '<img src="index.php?rex_img_type=rex_mediabutton_preview&rex_img_file=REX_FILE[1]" title="'."REX_VALUE[2]".'" alt="'."REX_VALUE[2]".'" />'."\r\n";
	}

	echo '<br/>'."\r\n";	
	echo '<br/>'."\r\n";
	echo '<strong>Rechts</strong>'."\r\n";
	echo '<br/>'."\r\n";	
	echo '<br/>'."\r\n";		
	echo '<b>Text:</b> REX_VALUE[5]';
	echo '<br/>';

    if ("REX_VALUE[9]" == "left") $ausrichtung2 = "links vom Text";
    if ("REX_VALUE[9]" == "right") $ausrichtung2 = "links vom Text";
			
    //  Wenn Bild eingefuegt wurde, Code schreiben 
    if ("REX_FILE[6]" != "") {
	echo '<br/>'."\r\n";		  
    echo '<b>Dateiname:</b> REX_FILE[6]'."\r\n";
	echo '<br/>'."\r\n";
	echo '<b>Titel:</b> REX_VALUE[7]'."\r\n";			  
	echo '<br/>'."\r\n";
	echo '<b>Bildunterschrift:</b> REX_VALUE[8]'."\r\n";
	echo '<br/>'."\r\n";
	echo '<b>Ausrichtung:</b> '.$ausrichtung2."\r\n";	
	echo '<br/>'."\r\n";
    echo '<b>Bild:</b>'."\r\n";
	echo '<br/>'."\r\n";
	echo '<img src="index.php?rex_img_type=rex_mediabutton_preview&rex_img_file=REX_FILE[6]" title="'."REX_VALUE[7]".'" alt="'."REX_VALUE[7]".'" />'."\r\n";
	}



}

?>