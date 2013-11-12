<div class="container" >
<h3>Text</h3>
	<strong>Text</strong>
	<span class="right">
		<textarea name="VALUE[1]" class="rex-markitup">REX_VALUE[1]</textarea>
	</span>
	<div class="clboth"></div>
</div>

<div class="container" >
<h3>Bild</h3>
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



