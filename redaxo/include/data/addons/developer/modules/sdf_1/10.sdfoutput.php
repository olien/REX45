<?php
$templateid = "REX_TEMPLATE_ID";
$ctypeid = "REX_CTYPE_ID";

if (!isset($REX['mendocon']['textmodulcount'])){
	$REX['mendocon']['textmodulcount'] = 0;
}
$REX['mendocon']['textmodulcount'] = $REX['mendocon']['textmodulcount'] + 1;

if (!isset($REX['mendocon']['contentrow'])){
	$REX['mendocon']['contentrow'] = 0;
}
if (isset($REX['mendocon']['templateid'])){
	$templateid = $REX['mendocon']['templateid'];
}
if (isset($REX['mendocon']['ctypeid'])){
	$ctypeid = $REX['mendocon']['ctypeid'];
}

if (OOAddon::isAvailable('textile'))
{
	$ueberschrift = '';
	$textile = '';
	$file = '';
	$tag = '';
	$txclass = '';
	
	// Überschrift
	if (REX_IS_VALUE[1])
	{
		$text = "REX_VALUE[1]";
		if ("REX_LINK_ID[2]" != '') 
		{
			$text = '<a href="'.rex_Geturl("REX_LINK_ID[2]", $REX['CUR_CLANG']).'">'.$text.'</a>';
		}
		$tag = "REX_VALUE[2]";
		if ($REX['REDAXO']) 
		{ 
			$text = $text . '&nbsp;<span>['.$tag.']</span>'; 
		}	
		$ueberschrift = "\n" . '<'.$tag.'>'.$text.'</'.$tag.'>';
	}
	
	// Textile Text
	if (REX_IS_VALUE[3])
	{
		$textile = htmlspecialchars_decode("REX_VALUE[3]");
		$textile = str_replace("<br />", "", $textile);
		$textile = rex_a79_textile($textile);
	} 
	
	//  Wenn Bild eingefuegt wurde, Code erzeugen 
	if ("REX_FILE[1]" != '') 
	{
		$imsize = "REX_VALUE[12]";
		
		// Bild-Rahmen
		$imclass = '';
		if ("REX_VALUE[10]" == "r")
		{
			$imclass = ' class="borderimg"';
		}
		
		// Klasse für figure
		$fclass = '';
		if ("REX_VALUE[9]" == 'u')
		{
			$fclass = 'center bottom';
		}
		if (("REX_VALUE[9]" == 'o') or ("REX_VALUE[9]" == 'uu'))
		{
			$fclass = 'center';
		}
		if (("REX_VALUE[9]" == 'l') or ("REX_VALUE[9]" == 'ol') or ("REX_VALUE[9]" == 'ul'))
		{
			$fclass = 'left';
		}
		if (("REX_VALUE[9]" == 'r') or ("REX_VALUE[9]" == 'or') or ("REX_VALUE[9]" == 'ur'))
		{
			$fclass = 'right';
		}
		if ("REX_VALUE[9]" == 'tl')
		{
			$fclass = 'imgleft';
			$txclass = ' txright';
		}		
		if ("REX_VALUE[9]" == 'tr')
		{
			$fclass = 'imgright';
			$txclass = ' txleft';
		}	
		
		$file = "\n" .'	<figure class="'.$fclass.'">';

		// Link auf Datei
		if ("REX_FILE[2]" != '')
		{
			$file .= "\n" . '	<a class="openfile" href="'.$REX['HTDOCS_PATH'] . 'files/REX_FILE[2]">';
		}
		// interner Link
		else if ("REX_LINK_ID[1]" != '') 
		{
			$file .= "\n" . '	<a href="'.rex_Geturl("REX_LINK_ID[1]", $REX['CUR_CLANG']).'">';
		}
		// externer Link
		else if ("REX_VALUE[11]" != "") 
		{
			$file .= "\n" . '	<a href="REX_VALUE[11]">';
		}
		// Bild in Fancybox öffnen
		else if ("REX_VALUE[5]" == "1") 
		{
			$file .= "\n" . '	<a class="fancybox" href="'.$REX['HTDOCS_PATH'] . 'files/REX_FILE[1]">';
		}
			
		// Bilddatei
		if ($REX['REDAXO'])
		{
			$file .= "\n" . '	<img src="index.php?rex_img_type=rex_mediapool_detail&amp;rex_img_file=REX_FILE[1]" title="'."REX_VALUE[7]".'" alt="'."REX_VALUE[7]".'" '.$imclass.' />';
		}
		else
		{
			if ("REX_VALUE[14]" <> '')
			{
					$file .= "\n" . '	<img src="files/REX_FILE[1]" title="'."REX_VALUE[7]".'" alt="'."REX_VALUE[7]".'" '.$imclass.' />';
			}
			else
			{
				if (($fclass == 'right') or ($fclass == 'left') or ($fclass == 'imgleft') or ($fclass == 'imgright'))
				{
					$file .= "\n" . '	<img src="index.php?rex_img_type=box_half_'.$imsize.'&amp;rex_img_file=REX_FILE[1]" title="'."REX_VALUE[7]".'" alt="'."REX_VALUE[7]".'" '.$imclass.' />';
				}
				else
				{
					$file .= "\n" . '	<img src="index.php?rex_img_type=box_full_'.$imsize.'&amp;rex_img_file=REX_FILE[1]" title="'."REX_VALUE[7]".'" alt="'."REX_VALUE[7]".'" '.$imclass.' />';
				}
			}	
		}
		
		// evtl. Linkende
		if (("REX_FILE[2]" != "") or ("REX_LINK[1]" != "") or ("REX_VALUE[11]" != "") or ("REX_VALUE[5]" == "1"))
		{
			$file .= "\n" . '	</a>';
		}
		
		// Untertitel
		if ("REX_VALUE[8]" <> '')
		{
			$file .= "\n" . '	<div class="subline">REX_VALUE[8]</div>';
		}	
		$file .= "\n" . '	</figure>';
	}
  
	// ----------------------------------------------------------------------------------------------
	// Modulausgabe
	// ----------------------------------------------------------------------------------------------
	
	if ((trim($ueberschrift)<>'') or (trim($file)<>'') or (trim($textile)<>''))
	{
		
		// Info im Backend ausgeben
		if ($REX['REDAXO'])
		{
			$bgcol = array(''=>'keine', '1'=>'hellgrau', 2=>'dunkelgrau', 3=>'blau', 4=>'gelb', 5=>'ohne, mit Rand');
			$infobr = '';
			$infosi = '';
			$infost = '';
			if ("REX_VALUE[4]" == '1')
			{ 
				$infobr = ' - Umbruch vor dem Inhalt ';
			}
			if ("REX_VALUE[13]" <> '') 
			{ 
				$infosi = ' - keine automatische Höhenanpassung ';
			}
			if ("REX_VALUE[15]" == '1') 
			{ 
				$infosi = ' - kleine Textgröße ';
			}
			if ("REX_VALUE[16]" == '1') 
			{ 
				$infosi = ' - große Textgröße ';
			}				
			echo '<strong style="color:#090;">Breite: REX_VALUE[12]%, Hintergrundfarbe: '.$bgcol['REX_VALUE[6]'].$infobr.$infosi.$infost.'</strong>';
		}
		
		// Umbruch ausgeben
		if ("REX_VALUE[4]" == '1')
		{
			$REX['mendocon']['contentrow'] = $REX['mendocon']['contentrow'] + 1;
			echo "\n" . '<div class="clearfix"></div>';
			$r = ' data-row="row'.$REX['mendocon']['contentrow'].'" ';
			echo "\n" . '<div class="spacing"'.$r.'></div>'."\n";
		}
		
		// Breite Inhaltselement
		$size = '';
		if ("REX_VALUE[12]" <> '') 
		{
			$size = " contentREX_VALUE[12] ";
		}

		// Hintergrundfarbe
		$box = '';
		if ("REX_VALUE[6]" <> '') 
		{
			$box = " colorboxREX_VALUE[6] ";
		}
		
		// No resize
		$noresize = '';
		if ("REX_VALUE[13]" <> '') 
		{
			$noresize = " noresize ";
		}	
		
		// kleiner Text
		$smalltext = '';
		if ("REX_VALUE[15]" == '1')
		{
			$smalltext = " smalltext ";
		}
	
		// großer Text
		$bigtext = '';
		if ("REX_VALUE[16]" == '1')
		{
			$bigtext = " bigtext ";
		}
		
		// Ausgabe Wrapper
		echo "\n" . '<div class="textile textile-'.$tag.$size.$box.$noresize.$smalltext.$bigtext.' row'.$REX['mendocon']['contentrow'].'">';

		// Ausgabe Image
		if ("REX_VALUE[9]" == 'uu')
		{
			echo $file;
		}	
		
		// Ausgabe der Überschrift
		if ($ueberschrift <> '')
		{
			echo $ueberschrift;
		}

		// Ausgabe Image
		if (("REX_VALUE[9]" == 'o') or ("REX_VALUE[9]" == 'or') or ("REX_VALUE[9]" == 'ol'))
		{
			echo $file;
		}

		// Ausgabe Text
		if ((trim($file)<>'') or (trim($textile)<>''))
		{
			if ("REX_VALUE[9]" == 'tl')
			{
				echo $file;
			}
			echo "\n" . '<div class="text text-'.$tag.$txclass.'">';
			if (("REX_VALUE[9]" == 'l') or ("REX_VALUE[9]" == 'r'))
			{
				echo $file;
			}
			echo "\n" . trim($textile);
			echo "\n" . '</div>';
			if ("REX_VALUE[9]" == 'tr')
			{
				echo $file;
			}
			echo "\n" . '<div class="clearfix"></div>' . "\n";
		}
			
		// Ausgabe Image
		if (("REX_VALUE[9]" == 'u') or ("REX_VALUE[9]" == 'ur') or ("REX_VALUE[9]" == 'ul'))
		{
			echo $file;
		}
		echo "\n" . '</div>' . "\n";
	}
}	
else
{
  echo rex_warning('Dieses Modul benötigt das "textile" Addon!');
}

//echo "<br>Text: template id = $templateid ctype id = $ctypeid";
?>