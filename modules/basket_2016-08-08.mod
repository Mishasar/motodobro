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
			$s = sql("SELECT MAX(num) FROM trans_pre");
			$r = mysql_fetch_array($s);
			$num = $r[0] + 1;
			
			$face_id = 1; $face_rec_id = 1;
			
			sql("INSERT INTO trans_pre (t_date, num, client, t_type, t_class, state1, curr, usd, euro,
				 nds_prc, nds_type, note, sum_order, sum_order_euro, sum_order_rub, face_id, face_rec_id, deliv) VALUES (NOW(), $num, $user_id, 7, 1, 1, 3, $usd, $euro,
				 18, 'выделить', '', 0, 0, 0, $face_id, $face_rec_id, $deliv_type )");
			$trn_id = mysql_insert_id();   

			
		
			$s = sql("SELECT b.*, d.brand, d.group_id, d.code, d.code_alt, d.descr, d.pr1, b.descr as descr_rus
				 FROM basket b, detali d WHERE d.id=b.prod_id AND tmp_usr='$tmp_user_id'");
			while ($r = mysql_fetch_array($s)):
			   $r['descr'] = str_replace("'", "", $r['descr']);
			   $r['descr'] = str_replace("\\", "", $r['descr']);
			   $r['descr_rus'] = str_replace("'", "", $r['descr_rus']);
			   $r['descr_rus'] = str_replace("\\", "", $r['descr_rus']);

			   sql("INSERT INTO trans_pre_inv (brand, group_id, code, code_alt, descr, pr1, pr2, trans_id, prod_id, curr, price, qty, status, descr_rus)
				 VALUES ($r[brand], $r[group_id], '$r[code]', '$r[code_alt]', '$r[descr]', $r[pr1], $r[price_usd], $trn_id, $r[prod_id], 1,
					$r[price_usd], $r[qty], 1, '$r[descr_rus]')");
			endwhile;
			
			sql ("DELETE FROM basket WHERE tmp_usr='$tmp_user_id'");
			
			
			// отправляем на почту
			//$to  = "www.extreme-factory.ru/parts <pavel@motoremont.ru>";
			$to  = "www.extreme-factory.ru/parts <pavel@motoremont.ru>";
			$subject = "Заказ из интернет магазина www.extreme-factory.ru/parts"; 

			$message = ' 
			<html> 
				<head> 
					<title>Заказ из интернет магазина www.extreme-factory.ru/parts</title> 
				</head> 
				<body> 
					<p>Заказ из интернет магазина www.extreme-factory.ru/parts</p>';

			
			$s = sql("SELECT c.phone, c.email, c.adress, c.full_name, d.name AS deliv FROM trans_pre t, client c, deliv d WHERE c.id=t.client AND d.id=t.deliv AND t.id=$trn_id");
			$r = mysql_fetch_array($s);
			$message .= '		
					<table cellpadding="2" cellmargin="0">
					<tr><td align="right">Клиент:</td><td>'.$r['full_name'].'</td></tr>
					<tr><td align="right">Адрес:</td><td>'.$r['adress'].'</td></tr>
					<tr><td align="right">Телефон:</td><td>'.$r['phone'].'</td></tr>
					<tr><td align="right">Email:</td><td>'.$r['email'].'</td></tr>
					<tr><td align="right">Способ доставки:</td><td>'.$r['deliv'].'</td></tr>	
					</table>';
			$i = 1;
			$message .= '		
					<table cellpadding="2" cellmargin="0" border="1">
					<tr><th width="30"><small>н/н</small></th><th width="120"><small>код</small></th><th><small>описание</small></th>
					     <th width="80"><small>цена</small></th><th width="30"><small>кол</small></th><th width="80"><small>сумма</small></th></tr>';					
			$s = sql("SELECT code, descr, descr_rus, price, curr, qty FROM trans_pre_inv WHERE trans_id=$trn_id");
			while ($r = mysql_fetch_array($s)):
				if ( $r['descr_rus'] != '' ): $descr = $r['descr_rus']; else: $descr = $r['descr']; endif;
				
				if ($r['curr'] == 1): $price = round($r['price'] * $usd, 2);
				elseif ($r['curr'] == 2): $price = round($r['price'] * $euro, 2);
				else: $price = $r['price'];
				endif;
				
				$sum = $price * $r['qty'];
				$message .= '<tr><td align="center">'.$i.'</td><td>'.$r['code'].'</td><td>'.$descr.'</td><td>'.number_format($price, 2, '.', ' ').'</td><td>'.$r['qty'].'</td><td>'.number_format($sum, 2, '.', ' ').'</td></tr>';
				$i ++;
			endwhile;
			$message .= '</table>';
			
			$message .= '		
				</body> 
			</html>'; 

			$headers  = "Content-type: text/html; charset=utf-8 \r\n"; 
			$headers .= "From: www.extreme-factory.ru/parts <pavel@motoremont.ru>\r\n"; 

			mail($to, $subject, $message, $headers); 			
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