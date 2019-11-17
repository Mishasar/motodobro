<?php
  $tpl -> define(array(cUnit => "cPart.tpl"));
  $tpl -> define_dynamic ( "row_new_oem_cat", "cUnit" );

  $part_id = $state_value;
  $s = sql("SELECT g.prim as g_name, b.name as b_name, m.name as model_name, my.name as year, u.name_rus, u.name,
                   u.id, u.year_id, u.model_id, u.brand_id, u.group_id, g.id as gid, b.pr_group, p.code, p.descr, p.descr_rus
            FROM wn_parts p, wn_units u, wn_model_year my, wn_model m, w_brand b, w_group g
            WHERE g.id=u.group_id AND b.id=u.brand_id AND m.id=u.model_id AND my.id=u.year_id AND u.id=p.unit_id AND p.id=$part_id");
  $r = mysql_fetch_array($s);
  $brand_id = $r['brand_id'];  $pr_group = $r['pr_group'];
  $model_id = $r['model_id'];
  $model_name = stripslashes($r['model_name']);
  if ($r['name_rus'] == ''): $unit_name = $r['name']; else: $unit_name = $r['name_rus']; endif;
  if ($r['descr_rus'] == ''): $part_name = $r['descr']; else: $part_name = $r['descr_rus']; endif;
  $code = $r['code'];
  
	$page_title = $r['b_name'].' '.$model_name;
  $title = $r['code'].' '.$part_name;
  $meta_key = $title. ' '.$page_title;

  $page_key = $r['g_name'].'<br>'.$page_title.'<br>'.$unit_name;
  $h1 = $page_title;
  $h3 = strtoupper($r['code'].' '.$part_name);

			   
	$navigate = '<li><a href="/">Главная</a> <span class="divider">/</span></li>
	  <li><a href="/1_'.$r['brand_id'].'_'.encodestring($r['g_name'].' '.$r['b_name']).'.html">'.$r['g_name'].' '.$r['b_name'].'</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/4_'.$r['model_id'].'_'.encodestring($model_name).'.html">'.$r['year'].' '.$model_name.'</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/5_'.$r['id'].'_'.encodestring($unit_name.' '.$model_name).'.html">'.$unit_name.'</a> <span class="divider">/</span></li>
	  <li class="active">'.$r['code'].'</li>';					   


  $tpl -> assign( array(  year_id =>  $r['year_id'],
                          unit_id => $r['id'] ));



// курс USD
$s = sql("SELECT value FROM currency_value WHERE curr_id=1 ORDER BY c_date DESC LIMIT 1");
$r = mysql_fetch_array($s);
$usd = $r['value'];

// поиск формулы расчета цены
  $s = sql("SELECT value FROM price p WHERE p.client_gr=15 AND p.prod_gr=$pr_group");
  $r = mysql_fetch_array($s);
  $sr_formula = $r['value'];
  if (isset($_REQUEST['log'])) {echo $_REQUEST['log']}

  $j = 1;
  $list_model = ''; $img_num = '';
  $s = sql("SELECT d.pr1, d.pr2, d.pr_int, d.group_id as d_group, d.id as d_id, IFNULL(d.code_ref, p.code_ref) AS code_ref,
                   p.id, p.code, p.descr, p.img_num, p.qty_unit, p.descr_rus, p.note
            FROM wn_parts p
            LEFT OUTER JOIN detali d ON d.code=p.code AND d.group_id=(SELECT b.pr_group FROM w_brand b WHERE b.id=p.brand_id)
            WHERE p.id=$part_id");
  while ($r = mysql_fetch_array($s)):
      $id = $r['d_id'];
      $pr1 = $r['pr1']; $pr2 = $r['pr2']; $pr_int = $r['pr_int'];
      $d_group = $r['d_group']; $code_ref = $r['code_ref'];
      if ($r['img_num'] > 0 && $r['img_num'] < 500) :$img_num = $r['img_num']; else: $img_num = '-'; endif;
      $img_num = $r['img_num'];

      if ($r['descr_rus'] <> ''): $descr = $r['descr_rus'];
      else: $descr = $r['descr']; endif;
      if ($descr == ''): $descr = '&nbsp;'; endif;
      if ($id > 0):
          if (($code_ref != '') and ($code_ref != 'NLA')):
             $code_ref_tmp = $code_ref;
             $i = 0;
             while ($code_ref_tmp != ''):
                 $i ++;
                 $s_ref = sql("SELECT pr1, pr2, pr_int, id as d_id, code_ref FROM detali WHERE code='".$code_ref."' AND group_id=".$d_group);
                 $r_ref = mysql_fetch_array($s_ref);
                 $code_ref_tmp = $r_ref['code_ref'];
                 if ($r_ref['code_ref'] == 'NLA'): $code_ref_tmp = ''; endif;
                 if ($i > 3): break; endif;
             endwhile;
             if ($r_ref['d_id'] > 0):
             $id = $r_ref['d_id'];
             $pr1 = $r_ref['pr1']; $pr2 = $r_ref['pr2']; $pr_int = $r_ref['pr_int'];
             endif;
          endif;
    
          // расчет цены
          if ($sr_formula <> ''):
            $formula = str_replace("pr1", $pr1, $sr_formula);
            $formula = str_replace("PR1", $pr1, $formula);
            $formula = str_replace("pr2", $pr2, $formula);
            $formula = str_replace("PR2", $pr2, $formula);
            $formula = str_replace(",", ".", $formula);
            eval("\$price=". $formula .";");
            if ($price == 0): $price = $pr2; endif;
          else:
            $price = $pr2;
          endif;
          $price_usd = $price;
          $price = $price * $usd;
      else:
         $price = 0;
      endif;
      if ($price > 0):
        $dis_price = number_format($price, 2, '.', '\'').'р';
      else: $dis_price = '--'; endif;
						  
		$list_model = '<tr><td ><span class="tbl_lable">Номер на рисунке</span>: <b>'.$img_num.'</b></span></td></tr>
                       <tr><td >Номер в каталоге</span>:';
         if ($code_ref != ''):
            $list_model .= '                <strike>'.$r['code'].'</strike> заменен на '.$code_ref.'</td></tr>';
         else:
            $list_model .= '                '.$r['code'].'</td></tr>';
         endif;
            $list_model .= '
                    <tr><td ><span class="tbl_lable">Описание</span>: '.$descr.'<br><i>'.$r['note'].'</i></td></tr>';
					
          if ($r['qty_unit'] > 1 ):
                $list_model .= '
                    <tr><td ><span class="tbl_lable">Количество в узле</span>: '.$r['qty_unit'].' шт.</td></tr>';
          endif;					
            $list_model .= '					
                    <tr><td ><span class="tbl_lable">Наличие</span>: Под заказ</td></tr>
                    <tr><td ><span class="tbl_lable">Цена за шт</span>: <b>'.number_format($price, 2, '.', ' ').'р</b></td></tr>';
                                            


          $list_model .= '
                    <tr><td>
                          <form action="/modules/basket_add.php" method="post" style="padding-top:10px; margin:0px;" id="product'.$r['id'].'">
                             <div class="input-prepend input-append">
								<input class="span2" id="appendedPrependedInput" size="16" type="number" value="'.$r['qty_unit'].'" name="qty" style="width:36px;">
								<button class="btn" type="submit" name="add" onclick="addProduct(\'#product'.$r['id'].'\');">В корзину</button>
							 </div>
							 <input type="hidden" name="add" value="btn">
							 <input type="hidden" name="id" value="'.$id.'">
                             <input type="hidden" name="price" value="'.$price.'">
                             <input type="hidden" name="descr" value="'.addslashes($descr).'">
                             <input type="hidden" name="price_usd" value="'.$price_usd.'">
                             <input type="hidden" name="back_uri" value="'.$_SERVER['REQUEST_URI'].'">
                          </form>
                        </td>
                    </tr>';
  endwhile;
  $list_model .= '</tr>';
  
         // Поиск в новых ОЕМ каталогах
		 
         $s2 = sql("SELECT g.prim as g_name, b.name as b_name, m.name as model_name, my.name as year, 
                    u.name_rus, u.name, p.unit_id
                    FROM wn_parts p, wn_units u, wn_model_year my, wn_model m, w_brand b, w_group g
                    WHERE g.id=p.group_id AND b.id=p.brand_id 
                      AND m.id=p.model_id AND my.id=p.year_id AND u.id=p.unit_id AND p.code='$code'
                    ORDER BY year, model_name, name");
         $cat_count = mysql_num_rows($s2);
         if ( $cat_count > 0):
         while ($r2 = mysql_fetch_array($s2)):
  
            if ($r2['name_rus'] <> ''): $unit_name = $r2['name_rus']; else: $unit_name = $r2['name']; endif;
            
            $oem_catalog = '<a href="'.$site_url.'/5_'.$r2['unit_id'].'_'.encodestring($unit_name.' '.$r2['model_name']).'.html" target="_blank">'
                   .$r2['g_name'].' '.$r2['b_name'].' :: '.$r2['model_name'].' ('.$r2['year'].') :: '.$unit_name.'</a>';

            $tpl -> assign( array( new_oem_catalog     => $oem_catalog ));
            $tpl -> parse(ROW_NEW_OEM_CAT, ".row_new_oem_cat");
         endwhile;
            $new_tlt_srh_count = '<div class="alert alert-info"><h4>Деталь с кодом <u>'.$code.'</u> найдена в '.$cat_count.' каталогах оригинальных запчастей:</h4></div>';
		 else:
            $tpl -> clear_dynamic ( "row_new_oem_cat" );
         endif;
		 
  $tpl -> assign( array(  h1 =>  $h1,
                          h3 =>  $h3,
                          navigate => $navigate,
                          new_tlt_srh_count => $new_tlt_srh_count,
                         list_model => $list_model ));  

  $tpl->parse(MAIN, "cUnit");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>