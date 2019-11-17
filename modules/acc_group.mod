<?php
	$tpl -> define(array(acc_catalog => "acc_group.tpl"));
  
	$group_id = $state_value;
	$gr_active = $group_id;  
  
	$s = sql("SELECT g.name_rus as g_name_rus, g.name as g_name, ct.name as c_name, g.catalog_id, ct.img
				FROM w_un_group g, w_un_catalog ct WHERE ct.id=g.catalog_id AND g.id=$group_id");
	$r = mysql_fetch_array($s);
	$catalog_id = $r['catalog_id'];
	if (trim($r['g_name_rus']) == ''): $g_name = $r['g_name']; else: $g_name = $r['g_name_rus']; endif;
	$g_name = stripslashes($g_name); 
	$catalog_name =  $r['c_name'];
	$big_img = $r['img'];	
  
	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li><li><a href="'.$site_url.'/6_'.$catalog_id.'_'.encodestring($catalog_name).'.html">'.$catalog_name.'</a> <span class="divider">/</span></li><li class="active">'.$g_name.'</li>';
  
	$tpl -> assign( array(  h1 =>  $g_name,
							h2 =>  $catalog_name,
							big_img => $big_img,
							navigate => $navigate ));
							
							

	$title = $g_name. '. ' .$catalog_name;
	$meta_key = $title;
	$meta_descr = $title;
	$page_title = $catalog_name;
	$page_key = $g_name.'<br> '. $catalog_name;


	$tpl -> define_dynamic ( "row_category", "acc_catalog" );

	$s = sql("SELECT name_rus, name, id FROM w_un_category WHERE group_id=$group_id AND category_id=0 ORDER BY name");
	while ($r = mysql_fetch_array($s)):
		trim($r['name_rus']) == '' ? $name_gr = $r['name'] : $name_gr = $r['name_rus'];
		
		$tpl -> assign( array(	CAT_CL     =>  'nav-header',
								CAT_NAME   =>  stripslashes($name_gr)));
		$tpl -> parse(ROWS_CATEGORY, ".row_category");



		$s3 = sql("SELECT name_rus, name, id FROM w_un_category WHERE group_id=$group_id AND category_id=".$r['id']." ORDER BY name");
		while ($r3 = mysql_fetch_array($s3)):
			trim($r3['name_rus']) == '' ? $cname = $r3['name'] : $cname = $r3['name_rus'];
			$url = $site_url.'/8_'.$r3['id'].'_'.encodestring($cname.' '.$catalog_name).'.html';
			$tpl -> assign( array(	CAT_CL     =>  '',
									CAT_NAME   =>  '<a href="'.$url.'">'.stripslashes($cname).'</a>'));
			$tpl -> parse(ROWS_CATEGORY, ".row_category");
		endwhile;


		$tbl_prod = '<ul class="thumbnails" style="margin-top:4px;">';
		$s3 = sql("SELECT name, name_rus, catalog_id, group_id, category_id, id
						FROM w_un_prod_group WHERE category_id=".$r['id']." ORDER BY RAND(UNIX_TIMESTAMP()) LIMIT 6");
		while ($r3 = mysql_fetch_array($s3)):
			trim($r3['name_rus']) == '' ? $name = $r3['name'] : $name = $r3['name_rus'];
			$url = $site_url.'/9_'.$r3['id'].'_'.encodestring($name).'.html';
			if (strlen ($name) > 30): $name = trim(substr($name, 0, 30)).'...'; endif;	

			$GrImg = $acc_img_url.$r3['catalog_id'].'/'.$r3['id'].'.jpg';
			$tbl_prod .= '<li class="span2"><div class="thumbnail"><a href="'.$url.'" style="display: inline-block; font: normal 11px/11px \'segoe_ui_light\', sans-serif; "><img src="'.$GrImg.'" alt="" style="margin-bottom:2px;">'.$name.'</a></div></li>';			
		endwhile;
		$tbl_prod .= '</ul>';
		
		$s3 = sql("SELECT COUNT(*) FROM w_un_prod_group WHERE category_id=".$r['id']);
		$r3 = mysql_fetch_array($s3);
		if ($r3[0] > 6):
		   $url = $site_url.'/8_'.$r['id'].'_'.encodestring($name_gr.' '.$catalog_name).'.html';
           $tbl_prod .= '<table border="0" cellspacing="4" cellpadding="0" width="100%">
                           <tr><td align="right"><a href="'.$url.'"><i class="icon-chevron-right"></i> Посмотреть все товары в разделе "'.$name_gr.'" ('.$r3[0].')</a></td></tr>';
           $tbl_prod .= '</table>';		
		endif;
		
		$tpl -> assign( array(CAT_CL     =>  '',
							 CAT_NAME   =>  $tbl_prod ));
		$tpl -> parse(ROWS_CATEGORY, ".row_category");



	endwhile;


	include ('acc_menu.mod');
	$tpl->parse(MAIN, "acc_catalog");
	$tpl_main = $tpl -> get_assigned(MAIN);
?>