<?php




# Variablen für Online-Prüfung
	$online = 'REX_VALUE[20]';
	$time = time();
	$start = strtotime('REX_VALUE[19]');
	$end = strtotime('REX_VALUE[18]');

echo 'REX_VALUE[20]<br />';
echo 'REX_VALUE[19]<br />';
echo 'REX_VALUE[18]<br />';


echo $online.'<br />';
echo $time.'<br />';
echo $start.'<br />';
echo $end.'<br />';

if(OOAddon::isAvailable('textile'))
{
  // Fliesstext 
  $content = '';
  if(REX_IS_VALUE[1])
  {
    $content = htmlspecialchars_decode("REX_VALUE[1]");
    $content = str_replace("<br />","",$content);
    $content = rex_a79_textile($content);
    $content = str_replace("###","&#x20;",$content);
    //print '<div class="txt-img">'. $content . '</div>';
  } 
}
else
{
  echo rex_warning('Dieses Modul benötigt das "textile" Addon!');
}





# Ausgabe im Backend
# Infobox Statusanzeige
if($REX['REDAXO'])	{
	echo '<div style="background-color: #e6eec6; padding: 10px; border: solid 1px grey;">';
	if ($online == "on") {
		echo '<span style="color: green;"><strong>Online-Prüfung ist aktiviert.</strong></span> ';
	} 
	else {
		echo '<span style="color: red;"><strong>Online-Prüfung ist deaktiviert.</strong></span> ';
	}
	  	echo  '<strong>Online von:</strong> '.date('d.m.Y H:i',$start).' | ';     
	  	echo  '<strong>Online bis:</strong> '.date('d.m.Y H:i',$end).' | ';    
	  	echo  '<strong>Aktuelle Zeit:</strong> '.date('d.m.Y H:i',$time).''; 
# Prüfung an
	if ($online == "on") {
	
		if( $time > $start && $time < $end )
		{
		    echo '<br /><span style="color: green;">Inhalt wird angezeit. Zeit ist aktiv!</span>';
		}
		else {
			echo '<br /><span style="color: red;">Inhalt nicht anzeigen. Zeit ist abgelaufen!!</span>';
		}
	}
# Prüfung aus
	if ($online == "") {
	    echo '<br /><span style="color: green;">Inhalt immer anzeigen. Prüfung ist deaktiviert!</span>';
	  }
	  	
	  	
	  	echo '<br /><hr /><span style="margin: 10px 0 10px 0; color: red;"><strong>Die Ausgabe erfolgt immer im Backend zu Kontrollzwecken, im Frontend abhängig von der Online-Prüfung!</strong></span>';
	  	echo '</div>';
	  	echo $content;
}
# Ende der Statusanzeige


# Modulausgabe ab hier
if(!$REX['REDAXO'])	{
# Prüfung an
	
//	echo $content;
	
	if ($online == "on") {
	
		if( $time > $start && $time < $end )
		{
		    	    
		    echo $content;
		}
		else {
			echo '';
		}
	}
# Prüfung aus
	if ($online == "") {
	    echo $content;
	  }
}



?>





