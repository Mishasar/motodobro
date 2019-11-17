<?php
  $title = 'Поиск товара';
  $h1 = $title;
  $meta_key = '';
  $meta_descr = '';
  $page_title = $title;
  $page_key = $title;

$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
				<li class="active">Поиск товара</li>';	

$tpl -> define(array(srh => "srh.tpl"));
$tpl -> define_dynamic ( "srh_row", "srh" );
$tpl -> define_dynamic ( "tlt_srh_row", "srh" );
$tpl -> define_dynamic ( "row_new_oem_cat", "srh" );

$new_tlt_srh_count = '';

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




$tpl -> assign( array(h1 =>  $h1, navigate => $navigate, srh_txt => $_REQUEST['srh_txt'], tlt_srh=> ''));

$srh_txt = htmlspecialchars(trim($_REQUEST['srh_txt']), ENT_QUOTES);
$lbl_srh = $srh_txt;
$srh_txt = str_replace('-', '', $srh_txt);
$srh_txt = str_replace('.', '', $srh_txt);
$srh_txt = str_replace(' ', '', $srh_txt);

$j =0;
if ($srh_txt != '' && strlen($srh_txt) > 3):

    $s = sql("SELECT d.code, g.name  FROM detali d, price_group g WHERE g.id=d.group_id AND g.id<>10 AND (d.code LIKE '$lbl_srh%' OR  d.code_alt LIKE '$srh_txt%')
				UNION 
				SELECT p.code, b.name  FROM wn_parts p, w_brand b WHERE b.id=p.brand_id AND (p.code LIKE '$lbl_srh%' OR p.code_alt LIKE '$srh_txt%')
				LIMIT 50");
    if (mysql_num_rows($s)>0):
		while ($r = mysql_fetch_array($s)):
		   	$code = $r['code'];
			$supplier = $r['name'];
			$s2 = sql("SELECT p.code, p.descr, p.descr_rus FROM wn_parts p, w_brand b WHERE p.brand_id=b.id AND b.name='$supplier' AND p.code='$code'");
			$r2 = mysql_fetch_array($s2);
			if ($r2['code'] != '') {
			  $descr = $r2['descr_rus'];
			  if ($descr == '') {$descr = $r2['descr'];}
			}  

			$s2 = sql("SELECT d.id, code, descr, descr_rus, code_ref, pr1, pr2, curr, group_id FROM detali d, price_group g WHERE d.group_id=g.id AND (g.name='$supplier' OR g.id=10) AND d.code='$code'");
			$r2 = mysql_fetch_array($s2);
			if ($r2['code'] != '') {
			  if ($descr == '') {$descr = $r2['descr_rus'];}
			  if ($descr == '') {$descr = $r2['descr'];}
			  if ($code_ref == '') {$code_ref = $r2['code_ref'];}
			  $id = $r2['id'];
			  $pr1 = $r2['pr1']; $pr2 = $r2['pr2']; $curr = $r2['curr'];
			  $pr_group = $r2['group_id'];
			}	   

			if ($id > 0) {			
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
						$code_ref = $r_ref['code'];
					}
				} else {
					$code_ref = '';
				}						
				
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
			 
				$price > 0 ? $dis_price = number_format($price, 2, '.', ' ').'р' : $dis_price = '--';
			}			
			
			if ($id > 0) {
				$add_to_basket = '<form action="'.$site_url.'/files/basket_add.php" method="post" style="padding:0px; margin:0px;" id="product'.$id.'">
								 <div class="input-prepend input-append">
									<input class="span2" id="appendedPrependedInput" size="16" type="number" value="1" name="qty" style="width:36px;">
									<button class="btn" style="height:30px;" type="submit" name="add" onclick="addProduct(\'#product'.$id.'\');">В корзину</button>
								 </div>
								 <input type="hidden" name="add" value="btn">
								 <input type="hidden" name="id" value="'.$id.'">
								 <input type="hidden" name="price" value="'.$price.'">
								 <input type="hidden" name="descr" value="'.addslashes($descr).'">
								 <input type="hidden" name="price_usd" value="'.$price_usd.'">
								 <input type="hidden" name="back_uri" value="'.$_SERVER['REQUEST_URI'].'">
							  </form>';		
			} else {
				$add_to_basket = 'Не поставляется';
			}				  
       
       $tpl -> assign( array( code     => '<a href="'.$site_url.'/supplier/'.urlencode($supplier).'/'.urlencode($code).'.html" class="code_lnk">'.$code.'</a>',
                              descr     => $descr. ' ' .$supplier,
                              price   =>  $dis_price,
                              add_to_basket => $add_to_basket
                              ));
       $tpl -> parse(SRH_ROW, ".srh_row");
       
         // Поиск в новых ОЕМ каталогах
		 /*
         $s2 = sql("SELECT p.unit_id, u.name, u.name_rus, m.name AS m_name, y.name AS y_name, b.name AS b_name, g.name AS g_name
						FROM wn_parts p, wn_units u, wn_model m, wn_model_year y, w_brand b, w_group g
						WHERE g.id=p.group_id AND b.id=p.brand_id AND y.id=p.year_id AND m.id=p.model_id AND u.id=p.unit_id AND p.code='$srh_txt'
						ORDER by g.ord, b.name, y.name, m.name, u.id LIMIT 600");
         $cat_count = mysql_num_rows($s2);
         if ( $cat_count > 0):
         while ($r2 = mysql_fetch_array($s2)):
  
            if ($r2['name_rus'] <> ''): $unit_name = $r2['name_rus']; else: $unit_name = $r2['name']; endif;
            
            $oem_catalog = '<a href="'.$site_url.'/5_'.$r2['unit_id'].'_'.encodestring($unit_name.' '.$r2['m_name']).'.html" target="_blank">'
                   .$r2['g_name'].' '.$r2['b_name'].' ['.$r2['y_name'].'] :: '.$r2['m_name'].' :: '.$unit_name.'</a>';

            $tpl -> assign( array( new_oem_catalog     => $oem_catalog ));
            $tpl -> parse(ROW_NEW_OEM_CAT, ".row_new_oem_cat");
         endwhile;
            $new_tlt_srh_count = '<div class="alert alert-info">Деталь с кодом <u>'.$srh_txt.'</u> найдена в '.$cat_count.' каталогах оригинальных запчастей:</div>';
		 else:
            $tpl -> clear_dynamic ( "row_new_oem_cat" );
         endif;
		*/
      endwhile;
		$tpl -> parse(TLT_SRH_ROW, ".tlt_srh_row");
		$tlt_srh = '<div class="alert alert-success">Результаты поиска по коду <u>'.$lbl_srh.'</u></div>';

    else:
        $tlt_srh = '<div class="alert alert-block">По запросу <u>'.$lbl_srh.'</u> ни чего не найдено!</div>';
		$tpl -> clear_dynamic ( "srh_row" );
		$tpl -> clear_dynamic ( "tlt_srh_row" );
        $tpl -> clear_dynamic ( "row_new_oem_cat" );		
    endif;
	
else:
   $tlt_srh = '<div class="alert alert-error"><h4>Ошибка!</h4> Код не может быть менее 3-х символов</div>';
   $tpl -> clear_dynamic ( "srh_row" );
   $tpl -> clear_dynamic ( "tlt_srh_row" );
   $tpl -> clear_dynamic ( "row_new_oem_cat" );  
endif;
     
	 $tpl -> assign( array(tlt_srh => $tlt_srh,
	                        new_tlt_srh_count => $new_tlt_srh_count));
							
  $tpl->parse(MAIN, "srh");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>