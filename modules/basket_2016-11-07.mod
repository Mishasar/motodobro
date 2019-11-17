<?php
  $title = 'Корзина покупок';
  $h1 = $title;
  $meta_key = '';
  $meta_descr = '';
  $page_title = $title;
  $page_key = $title;



if ( isset($_REQUEST['delete']) and $_REQUEST['delete'] > 0 ):
     sql("DELETE FROM basket WHERE tmp_usr='$tmp_user_id' AND prod_id=".$_REQUEST['delete']);
endif;

if ( isset($_REQUEST['order']) ):
	if (isset($_REQUEST['update'])):
		$array_am = $_REQUEST['array_am'];
		if (isset($array_am)):
			if (count($array_am)>0):
				foreach ($array_am as $row ) {
					 if ($row[qty]>0):
						$s = sql("UPDATE basket SET qty=$row[qty] WHERE tmp_usr='$tmp_user_id' AND prod_id=$row[id]");
					 endif;
				}
			endif;
		endif;
	else:
		if (isset($_REQUEST['deliv_type'])): $deliv_type = $_REQUEST['deliv_type']; else: $deliv_type = 0; endif;
		if (isset($_REQUEST['sms_phone'])): $sms_phone = $_REQUEST['sms_phone']; else: $sms_phone = ''; endif;
		$s = sql("UPDATE client SET sms_phone='$sms_phone' WHERE id=$user_id");
		
		$s = sql("SELECT * FROM basket WHERE (descr='' OR descr IS NULL) AND tmp_usr='$tmp_user_id'");
		if (mysql_num_rows($s) == 0):
			$s = sql("SELECT value FROM currency_value WHERE curr_id=1 ORDER BY c_date DESC LIMIT 1");
			$r = mysql_fetch_array($s);
			$usd = $r['value'];
			$s = sql("SELECT value FROM currency_value WHERE curr_id=2 ORDER BY c_date DESC LIMIT 1");
			$r = mysql_fetch_array($s);
			$euro = $r['value'];
			$s = sql("SELECT MAX(num) FROM trans");
			$r = mysql_fetch_array($s);
			$num = $r[0] + 1;
			
			$face_id = 1; $face_rec_id = 1;
			
			sql("INSERT INTO trans (t_date, num, client, t_type, t_class, state1, state2, state3, curr, usd, euro,
				 nds_prc, nds_type, note, sum_order, sum_order_euro, sum_order_rub, face_id, face_rec_id, deliv) VALUES (NOW(), $num, $user_id, 1, 1, 0, 0, 0, 3, $usd, $euro,
				 18, 'выделить', '', 0, 0, 0, $face_id, $face_rec_id, $deliv_type )");
			$trn_id = mysql_insert_id();   

			$order_sum_usd = 0;		
		
			$s = sql("SELECT b.*, d.brand, d.group_id, d.code, d.code_alt, d.descr, d.pr1, d.curr, b.descr as descr_rus
				 FROM basket b, detali d WHERE d.id=b.prod_id AND tmp_usr='$tmp_user_id'");
			while ($r = mysql_fetch_array($s)):
			   $r['descr'] = str_replace("'", "", $r['descr']);
			   $r['descr'] = str_replace("\\", "", $r['descr']);
			   $r['descr_rus'] = str_replace("'", "", $r['descr_rus']);
			   $r['descr_rus'] = str_replace("\\", "", $r['descr_rus']);

			   sql("INSERT INTO trans_inv (brand, group_id, code, code_alt, descr, pr1, pr2, trans_id, prod_id, curr, price, qty, status, descr_rus)
				 VALUES ($r[brand], $r[group_id], '$r[code]', '$r[code_alt]', '$r[descr]', $r[pr1], $r[price_usd], $trn_id, $r[prod_id], 1,
					$r[price_usd], $r[qty], 1, '$r[descr_rus]')");
					
				$order_sum_usd = $order_sum_usd + ($r['price_usd'] * $r['qty']);	
			endwhile;
			
			$order_sum_rub = $order_sum_usd * $usd;
			$order_sum_euro = $order_sum_rub / $euro; 
			$order_sum_usd = str_replace(",", ".", $order_sum_usd);
			$order_sum_rub = str_replace(",", ".", $order_sum_rub);
			$order_sum_euro = str_replace(",", ".", $order_sum_euro);
			sql ("UPDATE trans SET sum_order=$order_sum_usd, sum_order_euro=$order_sum_euro, sum_order_rub=$order_sum_rub WHERE id=$trn_id");
			
			
			sql ("DELETE FROM basket WHERE tmp_usr='$tmp_user_id'");			
		endif;
	endif;
endif;

$tpl -> define(array(basket => "basket.tpl"));
$tpl -> define_dynamic ( "order_row", "basket" );
$tpl -> define_dynamic ( "order_done", "basket" );
$tpl -> define_dynamic ( "order_done_reg", "basket" );
$tpl -> define_dynamic ( "order_done_no_reg", "basket" );
$tpl -> define_dynamic ( "order_no_sum", "basket" );

$s = sql("SELECT b.*, d.code, d.descr as en_descr
         FROM basket b 
         LEFT JOIN detali d ON d.id=b.prod_id WHERE tmp_usr='$tmp_user_id'");

$total_sum = 0; $i = 0;
$j =0;
if (mysql_num_rows($s)>0):
  while ($r = mysql_fetch_array($s)):
     $sum = $r['price'] * $r['qty'];
     $j ++;
     if ($j==2): $bgcolor = ' bgcolor="#48535b"'; $j =0; else: $bgcolor=' bgcolor="#37434a"'; endif;
        $tpl -> assign( array(id    => $r['prod_id'],
                              code     => addslashes($r['code']),
                              descr     => $r['descr'],
                              en_descr => addslashes($r['en_descr']),
                              price   =>  number_format($r['price'], 2, '.', ' '),
							  qty     => '<input class="span2" size="16" type="number" value="'.$r['qty'].'" name="array_am['.$i.'][qty]" style="width:56px;">
                                           <input type="hidden" name="array_am['.$i.'][id]" value="'.$r['prod_id'].'">',
                              sum    => number_format($sum, 2, '.', ' '),
                              del => '<a href="'.$site_url.'/basket.html?delete='.$r['prod_id'].'" class="btn btn-small btn-danger"><i class="icon-remove icon-white"></i> Удалить товар</a>'
                              ));
        $tpl -> parse(ORDER_ROW, ".order_row");

      $total_sum = $total_sum + $sum;
      $i ++;
  endwhile;
  
  $tpl -> parse(ORDER_DONE, ".order_done");

include ('modules/register.mod');

  
  if ($user_id>0):
	  if ($total_sum >= 1): 
		 
		 $tpl -> clear_dynamic ( "order_no_sum" );
		 $sf = sql("SELECT sms_phone FROM client WHERE id=$user_id");
		 $rf = mysql_fetch_array($sf);
         $sms_phone = $rf['sms_phone'];
		 $tpl -> assign( array(sms_phone => $sms_phone ));
		 $tpl -> parse(ORDER_DONE_REG, ".order_done_reg");
	  else: 
		 $tpl -> parse(ORDER_NO_SUM, ".order_no_sum");
		 $tpl -> clear_dynamic ( "order_done_reg" );	 
	  endif;  
      $tpl -> clear_dynamic ( "order_done_no_reg" );
  else:
	  if ($total_sum >= 1): 
		 $tpl -> clear_dynamic ( "order_no_sum" );
		 $tpl -> parse(ORDER_DONE_NO_REG, ".order_done_no_reg");
	  else: 
		 $tpl -> parse(ORDER_NO_SUM, ".order_no_sum");
		 $tpl -> clear_dynamic ( "order_done_no_reg" );	 
	  endif;  
      $tpl -> clear_dynamic ( "order_done_reg" );     
  endif;

else:
    $tpl -> assign( array(id => '&nbsp;',
                          code     => '&nbsp;',
                          descr     => '&nbsp;',
                          en_descr     => '&nbsp;',
                          price     => '&nbsp;',
                          qty     => '&nbsp;',
                          sum     => '&nbsp;',
                          del   => '&nbsp;'
                          ));
    $tpl -> parse(ORDER_ROW, ".order_row");
    $tpl -> clear_dynamic ( "order_done" );
    $tpl -> clear_dynamic ( "order_done_reg" );
    $tpl -> clear_dynamic ( "order_done_no_reg" );
    $tpl -> clear_dynamic ( "order_no_sum" );
endif;

	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
	  <li class="active">Корзина покупок</li>';	
	
    $tpl -> assign( array(h1 =>  $h1,
                          navigate => $navigate,
                          total_sum  => number_format($total_sum, 2, '.', ' '),
                          back_uri   => '<center><a href="'.$_REQUEST['back_uri'].'"><u>Продолжить покупки (Вернуться назад)</u></a> </center>'
                           ));

  $tpl->parse(MAIN, "basket");
  $tpl_main = $tpl -> get_assigned(MAIN);
		$auth_form_action = $site_url.'/basket.html';
?>