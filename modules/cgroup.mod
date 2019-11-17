<?php
  $tpl -> define(array(cGroup => "cgroup.tpl"));
  $group_id = $state_value;

  $brand_list = '';
  $s = sql("SELECT name FROM w_brand WHERE group_id=$group_id AND c_type=3 ORDER BY name");
  while ($r = mysql_fetch_array($s)):
    if ($brand_list != ''): $brand_list .= ', '; endif;
    $brand_list .= $r['name'];
  endwhile;
  

  $s = sql("SELECT * FROM w_group WHERE id=$group_id");
  $r = mysql_fetch_array($s);
  

  $title = $r['prim'].' '.$brand_list;
  $meta_key = $r['prim'].', '.$brand_list;
  $meta_descr = $title;
  $page_title = $r['prim'];
  $page_key = $r['prim'].'<br>'.$brand_list;
  
	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li><li class="active">'.$r['prim'].'</li>';	  


	$tpl -> define_dynamic ( "mototype", "cGroup" );   
		$mcont = ''; $brand = '';
		$s2 = sql("SELECT name, id FROM w_brand WHERE group_id=$group_id AND c_type=3");
		while ($r2 = mysql_fetch_array($s2)):
			$url = '1_'.$r2['id'].'_'.encodestring($r['prim'].' '.$r2['name']).'.html';
			$brand = '<li class="span2">
						<a href="'.$url.'" class="thumbnail">						  
						  <img src="'.$site_url.'/img/icons/brand'.$r2['id'].'.jpg" alt="Запчасти для '.$r2['name'].'" width="200" height="180">	  
						</a>
					  </li>';
			$mcont .= $brand;		  
		endwhile;
		
		$tpl -> assign( array(gr_name     =>  $title,
							  mcont   =>  $mcont));
		$tpl -> parse(MOTOTYPES, ".mototype"); 		
		
  $tpl -> assign( array(  gr_name =>  $r['name'],
                          gr_prim => $r['prim'],
                          gr_prim_s => mb_strtolower($r['prim']),
                          gr_id => $r['id'],
						  gr_note => $r['key_str'],
						  navigate => $navigate
   ));		
		

  $tpl->parse(MAIN, "cGroup");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>