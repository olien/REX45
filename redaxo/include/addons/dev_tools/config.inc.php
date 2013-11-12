<?php
$mypage = "dev_tools";

$REX['ADDON']['rxid'][$mypage] = 'xxx';
$REX['ADDON']['name'][$mypage] = 'Dev Tools';
$REX['ADDON']['page'][$mypage] = $mypage;
$REX['ADDON']['version'][$mypage] = "0.0";
$REX['ADDON']['author'][$mypage] = "Oliver Kreischer";
$REX['ADDON']['supportpage'][$mypage] = 'forum.redaxo.de';
$REX['ADDON']['perm'][$mypage] = $mypage . "[]";
$REX['PERM'][] = $mypage . "[]";

// --- DYN
$REX['ADDON']['dev_tools']['bild'] = '';
// --- /DYN

if (!$REX['REDAXO']) {

rex_register_extension('OUTPUT_FILTER', 'dev_tools_opf', array(), REX_EXTENSION_LATE);


	function dev_tools_opf($params)
		
	{
		
		$content = $params['subject'];
						
		$css = '<!-- Dev Tools -->'.PHP_EOL;
		$css .= '<style>
		  div.fadeMe {
			  position:fixed;
			  top: 0;
		     opacity:0.5;
			  width:100%;
			  height:100%;
			  z-index:10000;
			  background: url(http://2.bp.blogspot.com/-ZrxacXiov7w/TZIxzK-uKdI/AAAAAAAACJU/1IZ0eSJxbqs/s1600/Mac+lion-Full+screen+app.JPG) top center no-repeat;
		  }
		</style>
		';
		
		$html = '<!-- Dev Tools -->'.PHP_EOL;
		$html .= '<div class="fadeMe"></div>'.PHP_EOL;		
		
		$content = str_replace('</head>', $css.'</head>', $content);
		$content = str_replace('</body>', $html.'</body>', $content);
		return $content;
	}
}