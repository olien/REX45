<?php

if(!$REX['REDAXO']) {
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
			 <img src="'.$REX['HTDOCS_PATH'].'files/REX_FILE[1]" title="'."REX_VALUE[2]".'" alt="'."REX_VALUE[2]".'" />
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
			
			}
			else
			{
			  echo rex_warning('Dieses Modul benötigt das "textile" Addon!');
			}
} else {
	
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
	echo '<img src=" index.php?rex_img_type=rex_mediabutton_preview&rex_img_file=REX_FILE[1]" title="'."REX_VALUE[2]".'" alt="'."REX_VALUE[2]".'" />'."\r\n";
	}


}

?>