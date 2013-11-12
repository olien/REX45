<div style="background-color: #e6eec6; padding: 10px; border: solid 1px grey;">
<table width="100%">
<tr>
	<td width="250px">
	<strong>Online von/bis-Zeit ber&uuml;cksichtigen?</strong>
		<?php
		 if("REX_VALUE[20]" == "on" || "REX_VALUE[20]" == "On" || "REX_VALUE[20]" == 1)
			{
		    	echo('<input type="checkbox" checked="checked" id="online" name="VALUE[20]">');
		    }
		  else
		    {
		     	echo('<input type="checkbox" id="online" name="VALUE[20]">');
		    }
		?>
		</td>
		<td width="150px">
			von: <input type="text" size="15" name="VALUE[19]" value="REX_VALUE[19]" />
		</td>
		<td>
			bis: <input type="text" size="15" name="VALUE[18]" value="REX_VALUE[18]" />
		</td>
</tr>
</table>
</div>
<br /><br />
<?php

if(OOAddon::isAvailable('textile'))
{
?>

<strong>Fliesstext</strong>:<br />
<textarea name="VALUE[1]" cols="80" rows="10" class="inp100">REX_HTML_VALUE[1]</textarea>
<br />

<?php

rex_a79_help_overview(); 

}else
{
  echo rex_warning('Dieses Modul benötigt das "textile" Addon!');
}

?>