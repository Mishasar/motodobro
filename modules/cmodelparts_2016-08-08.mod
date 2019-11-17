<?php
  $tpl -> define(array(cUnit => "cmodelparts.tpl"));

  $unit_id = $state_value;
  $s = sql("SELECT g.prim as g_name, b.name as b_name, m.name as model_name, my.name as year, u.name_rus, u.name,
                   u.id, u.year_id, u.model_id, u.brand_id, u.group_id, g.id as gid, b.pr_group, u.img_big, u.img_path
            FROM wn_units u, wn_model_year my, wn_model m, w_brand b, w_group g
            WHERE g.id=u.group_id AND b.id=u.brand_id AND m.id=u.model_id AND my.id=u.year_id AND u.id=$unit_id");
  $r = mysql_fetch_array($s);
  $brand_id = $r['brand_id'];  $pr_group = $r['pr_group'];
  $model_id = $r['model_id'];
  $model_name = stripslashes($r['model_name']);
  if ($r['name_rus'] == ''): $unit_name = $r['name']; else: $unit_name = $r['name_rus']; endif;

  $title = $r['g_name'].' '.$r['b_name'].' '.$model_name.' '.$unit_name;
  $meta_key = $r['g_name'].', '.$r['b_name'].', '.$model_name.', '.$unit_name;
  $meta_descr = $title;
  $page_title = $r['b_name'].' '.$model_name;
  $page_key = $r['g_name'].'<br>'.$page_title.'<br>'.$unit_name;
  $h1 = strtoupper(str_replace("/", " / ", $unit_name));
  $h3 = strtoupper($r['g_name'].' '.$page_title);

			   
	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/0_'.$r['gid'].'_'.encodestring($r['g_name']).'.html">'.$r['g_name'].'</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/1_'.$r['brand_id'].'_'.encodestring($r['g_name'].' '.$r['b_name']).'.html">'.$r['b_name'].'</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/2_'.$r['year_id'].'_'.encodestring($r['g_name'].' '.$r['b_name'].' '.$r['year']).'.html">'.$r['year'].'</a> <span class="divider">/</span></li>
	  <li class="active">'.$model_name.'</li>';					   

		
	  if ($r['img_big'] != ''):
		$img_big = $site_url.'/pics/big/'.$r['img_path'].'/'.$r['img_big'].'.gif';
	  else:
		$img_big = $site_url.'/pics/big/default.gif';
	  endif;
	/*
	  if ($r['img_big'] != ''):
		$img_big = $site_url.'/files/y_img.php?file='.$r['img_path'].'_'.$r['img_big'];
	  else:
		$img_big = $site_url.'/files/y_img.php?file=default';
	  endif;
	 */ 
	$tpl -> assign( array(  img_big =>  $img_big ));
                          
                          
                          
  $i = 0;
  $list_unit = '<tr >';
  $s = sql("SELECT id, name_rus, name, year_id, img_small, img_path_sm FROM wn_units WHERE model_id=$model_id AND name <> '' ORDER BY name");
  while ($r = mysql_fetch_array($s)):
      if ($r['name_rus'] == ''): $unit_name = $r['name']; else: $unit_name = $r['name_rus']; endif;
	  if ($r['img_small'] != ''):
		$img = $site_url.'/pics/small/'.$r['img_path_sm'].'/'.$r['img_small'].'.gif';
	  else:
		$img = $site_url.'/pics/small/default.gif';
	  endif;	  
      $i ++;
      $list_unit .= '<td width="142" style="padding-bottom:4px; border: 1px dashed #d7d7d7;text-align: center;" valign="top">
						    <a href="'.$site_url.'/5_'.$r['id'].'_'.encodestring($unit_name.' '.$model_name).'.html" >
							<img src="'.$img.'" class="img-polaroid"><br>
                              '.$unit_name.'</a>
                      </td>';
      if ($i==6):
         $list_unit .= '</tr><tr>'; $i = 0;
      endif;
  endwhile;
  if ($i==1): $list_unit .= '<td style="border-right:0px;" colspan="5">&nbsp;</td>'; endif;
  if ($i==2): $list_unit .= '<td style="border-right:0px;" colspan="4">&nbsp;</td>'; endif;
  if ($i==3): $list_unit .= '<td style="border-right:0px;" colspan="3">&nbsp;</td>'; endif;
  if ($i==4): $list_unit .= '<td style="border-right:0px;" colspan="2">&nbsp;</td>'; endif;
  if ($i==5): $list_unit .= '<td >&nbsp;</td>'; endif;
  $list_unit .= '</tr>';



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


	$list_model = ''; $img_num = '';
	$s = sql("SELECT p.id, p.code, p.descr, p.img_num, p.qty_unit, p.descr_rus, p.note
            FROM wn_parts p
            WHERE p.unit_id=$unit_id ORDER BY p.id");
	while ($r = mysql_fetch_array($s)):
		$descr = '';
		$img_num = $r['img_num'];
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
			$list_model .= '<td >'.$img_num.'</td>';
			$list_model .= '<td>'.$r['code'].'</b><br><small><i>'.$descr.'<br>'.$r['note'].'</i></small></td>
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
				$list_model .= '<tr><td >'.$img_num.'</td><td>'.$r['code'].'</b><br><small><i>'.$descr.'</i></small></td><td >&nbsp;</td><td nowrap>---<br><span class="badge badge-inverse">Цена неизвестна</span></td></tr>';		
			}	
		}      

	endwhile;
	$tpl -> assign( array(  h1 =>  $h1,
							h3 =>  $h3,
							navigate => $navigate,
							list_unit => $list_unit,
							list_model => $list_model ));  

	$tpl->parse(MAIN, "cUnit");
	$tpl_main = $tpl -> get_assigned(MAIN);
?>