<?php


include('includes/phpqrcode/qrlib.php'); 
//include('config.php');      
    // outputs image directly into browser, as PNG stream 
    QRcode::png($_SERVER['REQUEST_URI'] , $_SERVER['DOCUMENT_ROOT'].'/tmp/'.$code.'.png', QR_ECLEVEL_L, 3, 6);
	$img_qr = 'http://motodobro.ru'.'/tmp/'.$code.'.png';
	
function russian_date($d){
    $date=explode(".", $d);
    switch ($date[1]){
            case 1: $m='янв'; break;
            case 2: $m='фев'; break;
            case 3: $m='мар'; break;
            case 4: $m='апр'; break;
            case 5: $m='мая'; break;
            case 6: $m='июн'; break;
            case 7: $m='июл'; break;
            case 8: $m='авг'; break;
            case 9: $m='сен'; break;
            case 10: $m='окт'; break;
            case 11: $m='ноя'; break;
            case 12: $m='дек'; break;
    }
    return $date[0] . ' ' . $m;
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
} 
else { 
    $cl_group = 1; 
}
	
	

$tpl -> define(array('cUnit' => "prod.tpl"));
$tpl -> define_dynamic ( "row_new_oem_cat", "cUnit" );

$s = sql("SELECT p.code, p.code_alt, p.descr, p.descr_rus FROM wn_parts p, w_brand b WHERE p.brand_id=b.id AND b.name_prc='$supplier' AND (p.code='$code' OR p.code_alt='$code') ORDER BY descr_rus DESC, descr DESC LIMIT 1 ");
//echo "SELECT p.code, p.code_alt, p.descr, p.descr_rus FROM wn_parts p, w_brand b WHERE p.brand_id=b.id AND b.name_prc='$supplier' AND (p.code='$code' OR p.code_alt='$code') ORDER BY descr_rus DESC, descr DESC LIMIT 1 ";
$r = mysql_fetch_array($s);
if ($r['code'] != '') {
        $descr_rus = $r['descr_rus'];
        $descr_en = $r['descr'];
        $note = $r['note'];
}  
if ($r['code_alt'] != '') {
        $wh = "(d.code='$code' OR d.code='".$r['code_alt']."')";
} else {
        $wh = "d.code='$code'";
}
  
$s = sql("SELECT d.id, code, descr, descr_rus, code_ref, pr1, pr2, curr, group_id FROM detali d, price_group g WHERE d.group_id=g.id AND (g.name='$supplier' OR g.id=10) AND $wh");
//echo "SELECT d.id, code, descr, descr_rus, code_ref, pr1, pr2, curr, group_id FROM detali d, price_group g WHERE d.group_id=g.id AND (g.name='$supplier' OR g.id=10) AND $wh";
$r = mysql_fetch_array($s);
if ($r['code'] != '') {
        if ($descr_rus == '') {$descr_rus = $r['descr_rus'];}
        if ($descr_en == '') {$descr_en = $r['descr'];}
        if ($code_ref == '') {$code_ref = $r['code_ref'];}
        $id = $r['id'];
        $pr1 = $r['pr1']; $pr2 = $r['pr2']; $curr = $r['curr'];
        $pr_group = $r['group_id'];
}
  
$descr = $descr_rus;
if ($descr == '') {$descr = $descr_en;}
$descr = str_replace("'", "", $descr); 


$s2 = sql("SELECT id FROM w_brand WHERE name='$supplier'");
$r2 = mysql_fetch_array($s2); 
$brand_id = $r2['id'];  
if ($brand_id == '') {
        $img_brand = $site_url.'/img/icons/brand0.jpg';
} else {
       $img_brand = $site_url.'/img/icons/brand'.$brand_id.'.jpg'; 
}
  
$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li><li class="active"><span itemprop="brand">'.$supplier.'</span> <span class="divider">/</span></li><li class="active">'.$code.'</li>';
$h1 = $code;
$h3 = $descr . ' ' . $supplier;
//$h3 = strtoupper($descr . ' ' . $supplier);
$page_title = $code .' - '. $descr . ' ' . $supplier;
$title = $page_title;
$meta_key = $page_title;
$page_key = $page_title;
$card_code = $code .'<br>'.$descr.'<br>'.$supplier;
  


	
$s3 = sql("SELECT SUM(qty) AS qty FROM ware_inv WHERE trans_id=0 AND code='".$code."' /*AND group_id=$pr_group*/");	
$r3 = mysql_fetch_array($s3);
if ($r3['qty'] > 0) {
    $nalich = 'В наличии';
    $deliv_time = 'возможна сегодня';
} else {
    $nalich = 'Под заказ';  
    $deliv_time = 'приблизительно '.russian_date( date('d.m.Y', strtotime ('+17 day')) ).'...'.russian_date( date('d.m.Y', strtotime ('+32 day')) );
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

    $price = ceil($price);
    $price_usd = $price/$usd;

    $price > 0 ? $dis_price = number_format($price, 2, '.', ' ') : $dis_price = '--';
}		
  
$list_model = '<tr ><td style="border-top:0px;" itemprop="productID">Номер в каталоге</span>:';
if ($code_ref != ''):
   $list_model .= '<strike>'.$code.'</strike> заменен на'.$code_ref.'</td></tr>';
else:
   $list_model .= ' '.$code.'</td></tr>';
endif;

if ($descr_rus != '') { 
    $list_model .= '<tr><td ><span class="tbl_lable">Описание</span>: <span itemprop="description">'.$descr_rus.'</span></td></tr>';
}
if ($descr_en != '') {	
    $list_model .= '<tr><td ><span class="tbl_lable">Описание ориг.</span>: <strong><span itemprop="description">'.$descr_en.'</span></strong><br><i>'.$note.'</i></td></tr>';	
}			

if ($id > 0) {			
    $list_model .= '					                    
    <tr><td ><span class="tbl_lable">Состояние</span>: Новая оригинальная запчасть</td></tr>
    <tr><td>
        <span class="tbl_lable">Наличие</span>: '.$nalich.'
    </td></tr>
    <tr><td><span class="tbl_lable">Доставка</span>: <strong>'.$deliv_time.'</strong></td></tr>
    <tr><td >
        <span class="tbl_lable">Цена</span>: 
        <span style="font-weight:800;">'.$dis_price.'р</span>
    </td></tr>';

    $list_model .= '
    <tr>
        <td>
            <form action="'.$site_url.'/files/basket_add.php" method="post" style="padding-top:10px; margin:0px;" id="product'.$r['id'].'">
                <div class="input-prepend input-append">
                    <input class="span2" id="appendedPrependedInput" size="16" type="number" value="1" name="qty" style="width:36px;">
                    <button class="btn" style="height:30px;" type="submit" name="add" onclick="addProduct(\'#product'.$r['id'].'\');">В корзину</button>
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
} else {
    $list_model .= '<tr><td ><span class="tbl_lable">Состояние</span>: Не поставляется</td></tr>';
}
  
// Поиск в новых ОЕМ каталогах

$s2 = sql("SELECT g.name as g_name, b.name as b_name, m.name as model_name, my.name as year, 
           u.name_rus, u.name, p.unit_id
           FROM wn_parts p, wn_units u, wn_model_year my, wn_model m, w_brand b, w_group g
           WHERE g.id=p.group_id AND b.id=p.brand_id 
             AND m.id=p.model_id AND my.id=p.year_id AND u.id=p.unit_id AND (p.code='$code' OR p.code_alt='$code')
           ORDER BY year, model_name, name LIMIT 150");
$cat_count = mysql_num_rows($s2);
if ( $cat_count > 0):
    while ($r2 = mysql_fetch_array($s2)):

       if ($r2['name_rus'] <> ''): $unit_name = $r2['name_rus']; else: $unit_name = $r2['name']; endif;

       $oem_catalog = '<a href="'.$site_url.'/5_'.$r2['unit_id'].'_'.encodestring($unit_name.' '.$r2['model_name']).'.html" target="_blank">'
              .$r2['g_name'].' '.$r2['b_name'].' :: '.$r2['model_name'].' ('.$r2['year'].') :: '.$unit_name.'</a>';

       $tpl -> assign( array( 'new_oem_catalog'     => $oem_catalog ));
       $tpl -> parse('ROW_NEW_OEM_CAT', ".row_new_oem_cat");
    endwhile;
    $new_tlt_srh_count = '<div class="alert alert-black">'.$descr.' '. $supplier . ', ' .$code. ' используется в следующих моделях техники ['.$cat_count.']</div>';
else:
    $tpl -> clear_dynamic ( "row_new_oem_cat" );
endif;
		 
$tpl -> assign( array(  'h1' =>  $h1,
                        'h3' =>  $h3,
                        'navigate' => $navigate,
                        'new_tlt_srh_count' => $new_tlt_srh_count,
                        'list_model' => $list_model,
                        'img_qr' => $img_qr,
                        'card_code' => $card_code,
                        'img_brand' => $img_brand,
                        'dis_price' => $dis_price,
                        'nalich' => $nalich)); 

$tpl->parse('MAIN', "cUnit");
$tpl_main = $tpl -> get_assigned('MAIN');
?>