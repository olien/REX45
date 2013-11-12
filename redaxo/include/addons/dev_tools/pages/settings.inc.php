<?php
$page = rex_request('page', 'string');
$subpage = rex_request('subpage', 'string');
$func = rex_request('func', 'string');
$javascriptmethod = rex_request('javascriptmethod', 'string');
$nojavascriptmethod = rex_request('nojavascriptmethod', 'string');

if (empty($javascriptmethod)) {
	$javascriptmethod = '0';
}

if (empty($nojavascriptmethod)) {
	$nojavascriptmethod = '0';
}

if ($func == "update") {
	$REX['ADDON']['email_obfuscator']['javascriptmethod'] = $javascriptmethod;
	$REX['ADDON']['email_obfuscator']['nojavascriptmethod'] = $nojavascriptmethod;
	
$content = '
$REX[\'ADDON\'][\'email_obfuscator\'][\'javascriptmethod\'] = \''.$javascriptmethod.'\';
$REX[\'ADDON\'][\'email_obfuscator\'][\'nojavascriptmethod\'] = \''.$nojavascriptmethod.'\';
$REX[\'ADDON\'][\'email_obfuscator\'][\'noscript_msg\'] = \''.$REX['ADDON']['email_obfuscator']['noscript_msg'].'\';
$REX[\'ADDON\'][\'email_obfuscator\'][\'noscript_msg_string_table_key\'] = \''.$REX['ADDON']['email_obfuscator']['noscript_msg_string_table_key'].'\';
';

	$file = $REX['INCLUDE_PATH']."/addons/email_obfuscator/config.inc.php";
	rex_replace_dynamic_contents($file, $content);
	
	echo rex_info('Einstellungen wurde aktualisiert.');
}
?>

<div class="rex-addon-output">

<h2 class="rex-hl2">Informationen</h2>
<div class="rex-area-content">
<p>
Anleitung</a>
</p>
</div>
</div>


<div class="rex-addon-output">

<h2 class="rex-hl2">Einstellungen</h2>
<div class="rex-area-content">
  <div class="rex-form">	
  <form action="index.php" method="get">
		<input type="hidden" name="page" value="email_obfuscator" />
	    <input type="hidden" name="subpage" value="" />
    	<input type="hidden" name="func" value="update" />
		<fieldset class="rex-form-col-1">
      <div class="rex-form-wrapper">
        <div class="rex-form-row">
		</div>
        <div class="rex-form-row">


        <div class="rex-form-row">
        <div class="rex-form-row">
			<p>
        		<input type="submit" class="rex-form-submit" name="sendit" value="Einstellungen speichern" />
          	</p>
		</div>
        
			</div>
    </fieldset>
  </form>
  </div>
</div>

</div>


<div class="rex-addon-output">

<h2 class="rex-hl2">Credits</h2>
<div class="rex-area-content">
<p>
Credits</a>
</p>
</div>
</div>
