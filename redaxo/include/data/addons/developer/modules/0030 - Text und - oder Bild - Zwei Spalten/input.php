<div class="container" >
<h3>Text - Spalte links</h3>
	<strong>Text</strong>
	<span class="right">
		<textarea name="VALUE[1]" class="markitup-text">REX_VALUE[1]</textarea>
	</span>
	<div class="clboth"></div>
</div>

<div class="container" >
<h3>Bild  - Spalte links</h3>
	<strong>Bild</strong>
	<span class="right">REX_MEDIA_BUTTON[1]</span>
	
	
	<strong>Title</strong>
	<span class="right"><input type="text" name="VALUE[2]" value="REX_VALUE[2]" /></span>
	
	<strong>Bildunterschrift</strong>
	<span class="right"><input type="text" name="VALUE[3]" value="REX_VALUE[3]" /></span>
	
	<strong>Ausrichtung</strong>
	<span class="right">
	<select name="VALUE[4]">
		<option value='left' <?php if ("REX_VALUE[4]" == 'left') echo 'selected'; ?>>links vom Text</option>
		<option value='right' <?php if ("REX_VALUE[4]" == 'right') echo 'selected'; ?>>rechts vom Text</option>
	</select>
	</span>
	<div class="clboth"></div>
</div>

<br/>
<br/>

<div class="container" >
<h3>Text - Spalte rechts</h3>
	<strong>Text</strong>
	<span class="right">
		<textarea name="VALUE[5]" class="markitup-text">REX_VALUE[5]</textarea>
	</span>
	<div class="clboth"></div>
</div>

<div class="container" >
<h3>Bild  - Spalte rechts</h3>
	<strong>Bild</strong>
	<span class="right">REX_MEDIA_BUTTON[6]</span>
	
	
	<strong>Title</strong>
	<span class="right"><input type="text" name="VALUE[7]" value="REX_VALUE[7]" /></span>
	
	<strong>Bildunterschrift</strong>
	<span class="right"><input type="text" name="VALUE[8]" value="REX_VALUE[8]" /></span>
	
	<strong>Ausrichtung</strong>
	<span class="right">
	<select name="VALUE[9]">
		<option value='left' <?php if ("REX_VALUE[9]" == 'left') echo 'selected'; ?>>links vom Text</option>
		<option value='right' <?php if ("REX_VALUE[9]" == 'right') echo 'selected'; ?>>rechts vom Text</option>
	</select>
	</span>
	<div class="clboth"></div>
</div>



<?php
a287_markitup::markitup('textarea.markitup-text',
  'h1,h2,h3,separator,bold,italic,separator,listbullet,listnumeric,separator,intlink,extlink,separator,mailtolink',
  '540','380'
);
?>