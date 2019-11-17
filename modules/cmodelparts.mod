<?php
$tpl -> define(array('cUnit' => "cmodelparts.tpl"));
    
$unit_id = $state_value;
$s = sql("SELECT g.prim as g_name, b.name as b_name, b.name_prc,  m.name as model_name, my.name as year, u.name_rus, u.name,
                 u.id, u.year_id, u.model_id, u.brand_id, u.group_id, g.id as gid, b.pr_group, u.img_big, u.img_path
          FROM wn_units u, wn_model_year my, wn_model m, w_brand b, w_group g
          WHERE g.id=u.group_id AND b.id=u.brand_id AND m.id=u.model_id AND my.id=u.year_id AND u.id=$unit_id");
$r = mysql_fetch_array($s);
$brand_id = $r['brand_id'];  $pr_group = $r['pr_group'];
$model_id = $r['model_id'];
$model_name = stripslashes($r['model_name']);
if ($r['name_rus'] == ''): $unit_name = $r['name']; else: $unit_name = $r['name_rus']; endif;

$supplier = $r['name_prc'];

$title = $r['g_name'].' '.$r['b_name'].' '.$model_name.' '.$unit_name;
$meta_key = $r['g_name'].', '.$r['b_name'].', '.$model_name.', '.$unit_name;
$meta_descr = $title;
$page_title = $r['b_name'].' '.$model_name;
$page_key = $r['g_name'].'<br>'.$page_title.'<br>'.$unit_name;
$h1 = strtoupper(str_replace("/", " / ", $unit_name));
$h3 = strtoupper($r['g_name'].' '.$page_title);

$schemaProp1 = '<span itemprop="category">'.strtoupper(str_replace("/", " / ", $unit_name)).'</span>';
$schemaProp2 = '<span itemprop="name">'.strtoupper($r['g_name']).'</span> <span itemprop="brand">'.strtoupper($r['b_name']).'</span> <span itemprop="model">'.strtoupper($model_name).'</span>';		   


$brand_name = $r['b_name'];

$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
  <li><a href="'.$site_url.'/0_'.$r['gid'].'_'.encodestring($r['g_name']).'.html">'.$r['g_name'].'</a> <span class="divider">/</span></li>
  <li><a href="'.$site_url.'/1_'.$r['brand_id'].'_'.encodestring($r['g_name'].' '.$r['b_name']).'.html">'.$r['b_name'].'</a> <span class="divider">/</span></li>
  <li><a href="'.$site_url.'/2_'.$r['year_id'].'_'.encodestring($r['g_name'].' '.$r['b_name'].' '.$r['year']).'.html">'.$r['year'].'</a> <span class="divider">/</span></li>
  <li class="active">'.$model_name.'</li>';

$hidden_navigation = '<input type="hidden" name="hidden_navigation" value="' . $r['g_name'] . '/' . $r['b_name'] . '/' . $r['year'].'">';
$hidden_brand = '<input type="hidden" name="hidden_brand" value=" ' . $r['b_name'] . '">';


  if ($r['img_big'] != ''):
    $img_big = 'http://motodobro.ru'.'/pics/big/'.$r['img_path'].'/'.$r['img_big'].'.gif';
  else:
    $img_big = 'http://motodobro.ru'.'/pics/big/default.gif';
  endif;
/*
  if ($r['img_big'] != ''):
    $img_big = $site_url.'/files/y_img.php?file='.$r['img_path'].'_'.$r['img_big'];
  else:
    $img_big = $site_url.'/files/y_img.php?file=default';
  endif;
 */
$tpl -> assign( array(  'img_big' =>  $img_big ));
                          
                          
                          
  $i = 0;
  $list_unit = '<tr >';
  $s = sql("SELECT id, name_rus, name, year_id, img_small, img_path_sm FROM wn_units WHERE model_id=$model_id AND name <> '' ORDER BY name");
  
  $units = '';
    while ($r = mysql_fetch_array($s)):
        if ($r['name_rus'] == ''): $unit_name = $r['name']; else: $unit_name = $r['name_rus']; endif;
        if ($r['img_small'] != ''):
              $img = 'http://motodobro.ru'.'/pics/small/'.$r['img_path_sm'].'/'.$r['img_small'].'.gif';
        else:
              $img = 'http://motodobro.ru'.'/pics/small/default.gif';
        endif;
        
        $units .= '<div><a href="'.$site_url.'/5_'.$r['id'].'_'.encodestring($unit_name.' '.$model_name).'.html" ><img src="'.$img.'" class="img-polaroid"><div class="unit-image">'.$unit_name.'</div></a></div>';
    endwhile;
    
    /*
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
*/


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
	$s = sql("SELECT p.id, p.code, p.code_alt, p.descr, p.img_num, p.qty_unit, p.descr_rus, p.note
            FROM wn_parts p
            WHERE p.unit_id=$unit_id ORDER BY p.id");
	while ($r = mysql_fetch_array($s)):
		$descr = '';
		$img_num = $r['img_num'];
		//$s2 = sql("SELECT * FROM detali WHERE code='".$r['code']."' OR code='".$r['code_alt']."' ORDER BY pr2, pr1 LIMIT 1");
                $s2 = sql("SELECT d.id, d.brand, d.group_id, d.code, d.code_alt, d.descr, d.descr_rus, 
                           d.pr1, d.pr2, d.nla, d.curr, d.code_ref, d.up_prc, d.tch, d.country, d.vendor, d.pr_int
                           FROM detali d INNER JOIN price_group g ON g.id=d.group_id AND g.id<>10 WHERE g.name='$supplier' AND (code='".$r['code']."' OR code='".$r['code_alt']."') ORDER BY pr2, pr1 LIMIT 1");
		$r2 = mysql_fetch_array($s2);
		$id = $r2['id'];
		

		if ($id > 0) {
			$pr1 = $r2['pr1']; $pr2 = $r2['pr2']; $curr = $r2['curr'];
			$pr_group = $r2['group_id'];
			$code_ref = $r2['code_ref'];
			$descr_rus = $r2['descr_rus']; $descr_en = $r2['descr']; 
			
			if ($code_ref != '' && $code_ref != 'NLA') {
				$code_ref_tmp = $code_ref;
				$i = 0;
				while ($code_ref_tmp != '') {
					$i ++;
					$s_ref = sql("SELECT pr1, pr2, curr, id as d_id, code_ref, group_id, descr_rus, descr, code FROM detali WHERE code='".$code_ref_tmp."'");
					$r_ref = mysql_fetch_array($s_ref);
					$code_ref_tmp = trim($r_ref['code_ref']);
					if ($r_ref['code_ref'] == 'NLA') { $code_ref_tmp = ''; }
					if ($i > 5) { break; }
				}
				
				if ($r_ref['d_id'] > 0) {
					$id = $r_ref['d_id'];
					$pr1 = $r_ref['pr1']; $pr2 = $r_ref['pr2'];
					$curr = $r_ref['curr'];
					$pr_group = $r_ref['group_id'];
					$descr_rus = $r_ref['descr_rus']; $descr_en = $r_ref['descr'];
					$code_ref = $r_ref['code'];
				}
			} else {
				$code_ref = '';
			}			
			
			if ($descr == '') $descr = trim($r['descr_rus']);
			if ($descr == '') $descr = trim($descr_rus);
			if ($descr == '') $descr = trim($r['descr']);
			if ($descr == '') $descr = trim($descr_en);
			if ($descr == '') $descr = '&nbsp;';
			

			
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
			
			if ($curr == 1) {$price_usd = $price; $price = $price * $usd;  }
			elseif ($curr == 2) {$price = $price * $euro; $price_usd = $price/$usd; }
			elseif ($curr == 3) {$price = $price; $price_usd = $price/$usd; }
			
			$price = ceil($price);
			$price_usd = $price/$usd;
		 
			$price > 0 ? $dis_price = number_format($price, 2, '.', ' ').'р' : $dis_price = '--';

			$list_model .= '<tr>';
			$list_model .= '<td nowrap>'.$img_num.'</td>';
			$list_model .= '<td>';
			if ($code_ref != '') {
				$list_model .= '<strike>'.$r['code'].'</strike><br><a href="'.$site_url.'/supplier/'.urlencode($supplier).'/'.urlencode($code_ref).'.html" class="code_lnk">'.$code_ref.'</a>';	
			} else {
				$list_model .= '<a href="'.$site_url.'/supplier/'.urlencode($supplier).'/'.urlencode($r['code']).'.html" class="code_lnk">'.$r['code'].'</a>';	
			}
			
			
			$list_model .= '<br><small><i>'.$descr.'<br>'.$r['note'].'</i></small></td>
				<td nowrap>'.$r['qty_unit'].'</td>
				<td nowrap>'.$dis_price.'<br>'.$nalich.'</td>
				<td nowrap>';
			if ($dis_price <> '--') { 
				$list_model .= '
					<form action="'.$site_url.'/files/basket_add.php" method="post" style="padding:0px; margin:0px;" id="product'.$id.'">';
				$list_model .= '	
					<button class="btn btn-danger" style="height:30px;" type="submit" name="add" onclick="addProduct(\'#product'.$id.'\');"><i class="fa fa-shopping-cart"></i></button>
					<input type="hidden" name="add" value="btn">
					<input type="hidden" name="id" value="'.$id.'">
					<input type="hidden" name="qty" value="1">
					<input type="hidden" name="price" value="'.$price.'">
					<input type="hidden" name="descr" value="'.addslashes($descr).'">
					<input type="hidden" name="price_usd" value="'.$price_usd.'">
					<input type="hidden" name="price_rub" value="'.$price.'">
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
				$list_model .= '<tr><td nowrap>'.$img_num.'</td><td>';
				if (isset($code_ref) && $code_ref != '') {
					$list_model .= '<strike>'.$r['code'].'</strike><br><b>'.$code_ref.'</b>';	
				} else {
					$list_model .= '<b>'.$r['code'].'</b>';	
				}				
				
				$list_model .= '<br><small><i>'.$descr.'</i></small></td><td>'.$r['qty_unit'].'</td><td nowrap colspan="2">---<br><span class="badge badge-inverse">Цена неизвестна</span></td></tr>';		
			}	
		}      

	endwhile;
        
        $s = sql("SELECT m.name as model_name FROM wn_model m WHERE m.id='$model_id'");
        $r = mysql_fetch_array($s);
        
        $unitLink = '<a href="'.$site_url.'/4_'.$model_id.'_'.encodestring($r['model_name']).'.html" style="font-size:14px;">Все детали для : '.$r['model_name'].'</a>';

            if ($brand_name == 'Harley Davidson'):
                $harlye_widget = '<table>
		                    <tr>
			                <td><h3>Присоединяйтесь к нашему сообществу Harley-Davidson в VK. Технические советы, события, объявления о продаже техники и б.у. запчастей.<h3></td>
			                <td>
			                <div id="vk_groups1"></div>
			                </td>
                            </tr>
		                  </table>
		                  <script type="text/javascript">
                                VK.Widgets.Group("vk_groups1", {mode: 0, width: "420", height: "200"}, 19051740);
                                </script>';
            else:
                $harlye_widget = '';
            endif;
  
	$tpl -> assign( array(  'h1' =>  $h1,
                                'h3' =>  $h3,
                                'hidden_navigation' => $hidden_navigation,
                                'hidden_brand' => $hidden_brand,
                                'navigate' => $navigate,
                                'list_unit' => $list_unit,
                                'units'=>$units,
                                'harlye_widget'=>$harlye_widget,
                                'unitLink'=>$unitLink,
                                'list_model' => $list_model,
                                'schemaProp1' => $schemaProp1,
                                'schemaProp2' => $schemaProp2));  

	$tpl->parse('MAIN', "cUnit");
	$tpl_main = $tpl -> get_assigned('MAIN');
?>