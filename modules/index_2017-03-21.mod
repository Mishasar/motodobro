<?php

  $title = 'Мотозапчасти на заказ из Японии и США!';
  $meta_key = 'honda, kawasaki, suzuki, yamaha, байк, байкеры, доставка, заказ запчастей, заказ мотозапчастей, мото, мото запчасти, мотозапчасти, мотоцикл';
  $meta_descr = 'МотоДобро - Мотозапчасти на заказ из Японии и США!';

  $tpl -> define(array(index => "index.tpl"));
 
	$tpl -> define_dynamic ( "mototype", "index" );
	$s = sql("SELECT name, prim, prim2, id FROM w_group WHERE id NOT IN (9,10,11) ORDER BY ord");
	while ($r = mysql_fetch_array($s)):
		$mcont = ''; $brand = '';
		$s2 = sql("SELECT name, id FROM w_brand WHERE group_id=".$r['id']." AND c_type=3");
		while ($r2 = mysql_fetch_array($s2)):
			$url = $site_url.'/1_'.$r2['id'].'_'.encodestring($r['prim'].' '.$r2['name']).'.html';
			$brand = '<li class="span2">
						<a href="'.$url.'" class="thumbnail">						  
						  <img src="'.$site_url.'/img/icons/brand'.$r2['id'].'.jpg" alt="Запчасти для '.$r2['name'].'">	  
						</a>
					  </li>';
			$mcont .= $brand;		  
		endwhile;
		 
		$tpl -> assign( array(gr_name     =>  $r['prim2'],
							  mcont   =>  $mcont));
		$tpl -> parse(MOTOTYPES, ".mototype");   
	endwhile;

  $tpl->parse(MAIN, "index");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>