<?php
	$tpl -> define(array(acc_catalog => "acc_index.tpl"));
	  
	$catalog_id = $state_value;
	$gr_active = 0; $cat_active = 0;
 
	$s = sql("SELECT name, descr, img FROM w_un_catalog WHERE id=$catalog_id");
	$r = mysql_fetch_array($s);
	$big_img = $r['img'];
	$catalog_type = $r['tpl'];
	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li><li class="active">'.$r['name'].'</li>';

	$tpl -> assign( array(	big_img =>  $big_img,
							cat_name    => $r['name'],
							navigate => $navigate ));

	$catalog_name =  $r['name'];                   
	$title = $r['name'].'. Неоригинальные запчасти и аксессуары';
	$meta_key = $r['name'].'. Неоригинальные запчасти и аксессуары';
	$meta_descr = $title;
	$page_title = $r['name'];
	$page_key = $r['name'].'<br> Неоригинальные запчасти и аксессуары';
  
	// Категории
	$tpl -> define_dynamic ( "index_row_cat", "acc_catalog" );
	$s = sql("SELECT g.name_rus as gr_name_rus, g.name as gr_name, g.id as gr_id, c.name_rus, c.name, c.id,
				(SELECT COUNT(*) FROM w_un_category WHERE group_id=g.id) as cnt
			  FROM w_un_group g
			  LEFT OUTER JOIN w_un_category c ON c.group_id=g.id
			  WHERE g.catalog_id=$catalog_id AND c.category_id=0 ORDER BY g.name, c.name");
	$name_gr_print = '';
	while ($r = mysql_fetch_array($s)):
		trim($r['gr_name_rus']) == '' ? $name_gr = $r['gr_name'] : $name_gr = $r['gr_name_rus'];

		if ($name_gr_print != $name_gr) {
			$tpl -> assign( array(	INDEX_CL     =>  'nav-header',
									INDEX_NAME   =>  stripslashes($name_gr) ));
			$tpl -> parse(INDEX_ROWS_CAT, ".index_row_cat");      
		}

		if ($r['cnt'] > 1) {
			   $name_gr_print = $name_gr;
			   if (trim($r['name_rus']) == ''): $name = $r['name']; else: $name = $r['name_rus']; endif;
			   $url = $site_url.'/8_'.$r['id'].'_'.encodestring($name.' '.$catalog_name).'.html';
			   $tpl -> assign( array(INDEX_CL     =>  '',
									 INDEX_NAME   =>  '<a class="" href="'.$url.'">'.stripslashes($name).'</a>'));
			   $tpl -> parse(INDEX_ROWS_CAT, ".index_row_cat");
		} else {

			$tbl_prod = '<ul class="thumbnails" style="margin-top:4px;">';
			$s3 = sql("SELECT name, name_rus, catalog_id, group_id, category_id, id
							FROM w_un_prod_group WHERE group_id=".$r['gr_id']." LIMIT 6");
			while ($r3 = mysql_fetch_array($s3)):
				trim($r3['name_rus']) == '' ? $name = $r3['name'] : $name = $r3['name_rus'];
				$url = $site_url.'/9_'.$r3['id'].'_'.encodestring($name).'.html';

				if (strlen ($name) > 30) $name = trim(substr($name, 0, 30)).'...';

				$GrImg = $acc_img_url.$r3['catalog_id'].'/'.$r3['id'].'.jpg';
				$tbl_prod .= '<li class="span2"><div class="thumbnail"><a href="'.$url.'" style="display: inline-block; font: normal 11px/11px \'segoe_ui_light\', sans-serif; "><img src="'.$GrImg.'" alt="" style="margin-bottom:2px;">'.$name.'</a></div></li>';
			endwhile;
			$tbl_prod .= '</ul>';
			   
				$s3 = sql("SELECT COUNT(*) FROM w_un_prod_group WHERE category_id=".$r['id']);
				$r3 = mysql_fetch_array($s3);
				if ($r3[0] > 6) {
				   $url = $site_url.'/8_'.$r['id'].'_'.encodestring($name_gr.' '.$catalog_name).'.html';
				   $tbl_prod .= '<table border="0" cellspacing="4" cellpadding="0" width="100%">
								   <tr><td align="right"><a href="'.$url.'"><i class="icon-chevron-right"></i> Посмотреть все товары в разделе "'.$name_gr.'" ('.$r3[0].')</a></td></tr>';
				   $tbl_prod .= '</table>';		
				}		   

				$tpl -> assign( array(	INDEX_CL     =>  '',
										INDEX_NAME   =>  $tbl_prod ));
				$tpl -> parse(INDEX_ROWS_CAT, ".index_row_cat");

		}
	endwhile;

	include ('acc_menu.mod');
	$tpl->parse(MAIN, "acc_catalog");
	$tpl_main = $tpl -> get_assigned(MAIN);
?>