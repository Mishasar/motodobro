<?php
$tpl -> define(array(acc_catalog => "acc_prod.tpl"));
$prod_id = $state_value;
  
	$s = sql("SELECT c.name_rus as c_name_rus, c.name as c_name, c.id AS c_id, g.name_rus as g_name_rus, g.name as g_name, g.id AS g_id, ct.name as ct_name, tlt, ct.vend_id, c.category_id as sub_cat, ct.img, 
					p.catalog_id, p.name, p.name_rus, p.features, p.features_rus
					FROM w_un_category c, w_un_group g, w_un_catalog ct, w_un_prod_group p WHERE ct.id=c.catalog_id AND g.id=c.group_id AND c.id=p.category_id AND p.id=$prod_id");
	$r = mysql_fetch_array($s);
	$catalog_id = $r['catalog_id'];
	$catalog_name =  $r['ct_name'];
	$gr_active = $r['g_id'];
	$cat_active = $r['c_id'];
	$big_img = $r['img'];  
  
	trim($r['c_name_rus']) == '' ? $c_name = $r['c_name'] : $c_name = $r['c_name_rus'];
	$c_name = stripslashes($c_name);
	trim($r['g_name_rus']) == '' ? $g_name = $r['g_name'] : $g_name = $r['g_name_rus'];
	$g_name = stripslashes($g_name);
	
	trim($r['features_rus']) == '' ? $features = $r['features'] : $features = $r['features_rus'];
	$features = stripslashes($r['features']);	
	trim($r['name_rus']) == '' ? $p_name = $r['name'] : $p_name = $r['name_rus'];	
	$p_name = stripslashes($p_name);
	
	strlen ($p_name) > 40 ? $p_name_nav = trim(substr($p_name, 0, 40)).'...' : $p_name_nav = $p_name;
	
	
	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li><li><a href="'.$site_url.'/6_'.$catalog_id.'_'.encodestring($catalog_name).'.html">'.$catalog_name.'</a> <span class="divider">/</span></li>
		<li><a href="'.$site_url.'/7_'.$gr_active.'_'.encodestring($g_name.' '.$catalog_name).'.html">'.$g_name.'</a> <span class="divider">/</span></li>
		<li><a href="'.$site_url.'/8_'.$cat_active.'_'.encodestring($$c_name.' '.$catalog_name).'.html">'.$c_name.'</a> <span class="divider">/</span></li>
		<li class="active">'.$p_name_nav.'</li>'; 

	$diogramm = '';
	$sd = sql("SELECT * FROM w_un_prod_group_img WHERE prod_group_id=$prod_id");
	while ($rd = mysql_fetch_array($sd)):
		$d_img = $acc_chart_img_url.$rd['img'];
		$size = getimagesize($d_img);
		$width = $size[0] + 60;			
		$diogramm .= '<br><button class="btn btn-info" style="margin-bottom:10px;" onclick="zoom(\''.$d_img.' \',\''.$width.'\',\''.$size[1].'\', \''.stripslashes($rd['capt']).'\'); return false"><i class="icon-th-list"></i> '.stripslashes($rd['capt']).'</button>';				
	endwhile;	
		
		
	$tpl -> assign( array(  h1 =>  $p_name,
							h2 =>  $c_name.'. '.$g_name,
							big_img => $big_img,
							navigate => $navigate,
							features => $features,
							diogramm => $diogramm
							)); 

	$title = $p_name. '. ' .$catalog_name;
	$meta_key = $title;
	$meta_descr = $title;
	$page_title = $catalog_name;
	$page_key = $p_name.'<br> '. $catalog_name;	
							
	$group_img = $acc_img_url.$catalog_id.'/'.$prod_id.'.jpg';				
	$gi = '<img src='.$group_img.' border="0" alt="'.$name.'" name="big" style="margin-right:40px;">';
	$tpl -> assign( array(group_img   => $gi, group_descr =>  $name));

	$tpl -> define_dynamic ( "adv_img_block", "acc_catalog" );
	$j = 0;
	for ($i = 1; $i <= 6; $i++) {
		$add_img = $acc_img_url.$catalog_id.'/'.$prod_id.'_'.$i.'.jpg';
		$size = getimagesize($add_img);
		$width = $size[0];
		if ($width > 10):
			$tpl -> assign( array( adv_img    => $add_img, adv_descr => $name  ));
			$tpl -> parse(ORDER_ROW, ".adv_img_block");
			$j ++;
		endif;
	}
	
	if ($j == 0) {
		$tpl -> clear_dynamic ( "adv_img_block" ); 
	} else {
		$tpl -> assign( array( adv_img    => $group_img, adv_descr => $name  ));
		$tpl -> parse(ORDER_ROW, ".adv_img_block");
	}


  

	// курсы
	$s = sql("SELECT value FROM currency_value WHERE curr_id=1 ORDER BY c_date DESC LIMIT 1");
	$r = mysql_fetch_array($s);
	$usd = $r['value'];
	$s = sql("SELECT value FROM currency_value WHERE curr_id=2 ORDER BY c_date DESC LIMIT 1");
	$r = mysql_fetch_array($s);
	$euro = $r['value'];
	
	// группа клиента
	$sr_formula = '';
	if ($user_id > 0) { 
		$s = sql("SELECT group_id FROM client WHERE id=$user_id");
		$r = mysql_fetch_array($s);
		$cl_group = $r['group_id'];
	} else { $cl_group = 1; }
	






	$list_model = ''; $code_tst = '';

	$s = sql("SELECT * FROM w_un_prod p WHERE p.prod_group_id=$prod_id ORDER BY p.code");
	while ($r = mysql_fetch_array($s)):
	if ($code_tst <> $r['code']) {
		$descr = '';
		$s2 = sql("SELECT * FROM detali WHERE code='".$r['code']."' ORDER BY pr2, pr1 LIMIT 1");
		$r2 = mysql_fetch_array($s2);
		$id = $r2['id'];
		if ($id > 0) {
			if ($descr == '') $descr = trim($r['descr_rus']);
			if ($descr == '') $descr = trim($r2['descr_rus']);
			if ($descr == '') $descr = trim($r['descr']);
			if ($descr == '') $descr = trim($r2['descr']);
			if ($descr == '') $descr = '&nbsp;';
			
			$pr1 = $r2['pr1']; $pr2 = $r2['pr2']; $curr = $r2['curr'];
			$pr_group = $r2['group_id'];
			
			$s3 = sql("SELECT SUM(qty) AS qty FROM ware_inv WHERE trans_id=0 AND code='".$r['code']."' /*AND group_id=$pr_group*/");	
			$r3 = mysql_fetch_array($s3);
			$r3['qty'] > 0 ? $nalich = '<span class="badge badge-success">В&nbsp;наличии</span>' : $nalich = '<span class="badge">Под&nbsp;заказ</span>';			
			
			if ($user_id > 0) {
				$s3 = sql("SELECT value FROM price_client WHERE client=$user_id AND prod_gr=$pr_group"); //client, prod_gr, value
				$r3 = mysql_fetch_array($s3);
				$sr_formula = $r3['value'];			
			}
			// поиск формулы расчета цены
			if ($sr_formula == '') {
				$s3 = sql("SELECT value FROM price p WHERE p.client_gr=$cl_group AND p.prod_gr=$pr_group");
				$r3 = mysql_fetch_array($s3);
				$sr_formula = $r3['value'];
			}		
		 
			// расчет цены
			if ($sr_formula <> '') {
				$formula = str_replace("pr1", $pr1, $sr_formula);
				$formula = str_replace("PR1", $pr1, $formula);
				$formula = str_replace("pr2", $pr2, $formula);
				$formula = str_replace("PR2", $pr2, $formula);
				$formula = str_replace(",", ".", $formula);
				eval("\$price=". $formula .";");
			} else {
				$price = $pr2;
			}
			
			if ($curr == 1) {$price = $price * $usd; $price_usd = $price; }
			elseif ($curr == 2) {$price = $price * $euro; $price_usd = $price/$usd; }
			elseif ($curr == 3) {$price = $price; $price_usd = $price/$usd; }
		 
			$price > 0 ? $dis_price = number_format($price, 2, '.', ' ').'р' : $dis_price = '--';

			$list_model .= '<tr>';
			$list_model .= '<td>'.$r['code'].'</b><br><small><i>'.$descr.'</i></small></td>
				<td nowrap>'.$dis_price.'<br>'.$nalich.'</td>
				<td style="width:100px;">';
			if ($dis_price <> '--') { 
				$list_model .= '
					<form action="'.$site_url.'/files/basket_add.php" method="post" style="padding:0px; margin:0px;" id="product'.$id.'">
					<div class="input-prepend input-append">
					<input class="span2" id="appendedPrependedInput" type="number" value="1" name="qty" style="width:40px;">
					<button class="btn" style="height:30px;" type="submit" name="add" onclick="addProduct(\'#product'.$id.'\');">В корзину</button>
					</div>
					<input type="hidden" name="add" value="btn">
					<input type="hidden" name="id" value="'.$id.'">
					<input type="hidden" name="price" value="'.$price.'">
					<input type="hidden" name="descr" value="'.addslashes($p_name.'. '.$descr).'">
					<input type="hidden" name="price_usd" value="'.$price_usd.'">
					<input type="hidden" name="back_uri" value="'.$_SERVER['REQUEST_URI'].'">
					</form>';
			} else {
				$list_model .= '&nbsp;';
			}
			$list_model .= '
			</td>
			</tr>';						
		} else {
			if ($r['code'] != '') {
				if ($descr == '') $descr = trim($r['descr_rus']);
				if ($descr == '') $descr = trim($r['descr']);
				if ($descr == '') $descr = '&nbsp;';
				$list_model .= '<tr><td>'.$r['code'].'</b><br><small><i>'.$descr.'</i></small></td><td >&nbsp;</td><td nowrap>---<br><span class="badge badge-inverse">Цена неизвестна</span></td></tr>';		
			}	
		}
	}	
	$code_tst = $r['code'];
	endwhile;
	$list_model .= '</tr>';
	$tpl -> assign( array( list_model => $list_model ));

	include ('acc_menu.mod');
	$tpl->parse(MAIN, "acc_catalog");
	$tpl_main = $tpl -> get_assigned(MAIN);
?>