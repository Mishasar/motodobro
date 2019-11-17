<?php

  $s2 = sql("SELECT * FROM site_template WHERE id=2");
  $r2 = mysql_fetch_array($s2);
  
	$title = $r2['page_header'];
	$meta_key = $r2['page_header'];
	$meta_descr = $r2['page_header'];

	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li><li class="active">'.$r2['page_header'].'</li>';
	$back = '<a href="{_SITE_}/reg2.html?enter=1" role="button" class="btn btn-large btn-inverse" ><i class="icon-arrow-left icon-white"></i> Назад </a>';
	
    $tpl -> assign( array(	navigate => $navigate,
							h1 => $r2['page_header'],
							content  => $r2['page_content'],
							back => $back	));	
	$tpl -> define(array(index => "right.tpl"));
	
	$tpl->parse(MAIN, "index");
	$tpl_main = $tpl -> get_assigned(MAIN);

?>