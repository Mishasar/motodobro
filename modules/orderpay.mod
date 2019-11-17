<?php
  $title = 'Оплата заказа';
  $h1 = $title;
  $meta_key = '';
  $meta_descr = '';
  $page_title = $title;
  $page_key = $title;


$order_id = 0;
$status = 0;

//print_r($_REQUEST);

if ( isset($_REQUEST['pay']) ) {
    $order_md5 = $_REQUEST['pay'];
	$s = sql("SELECT id, state1 FROM trans WHERE order_md5='$order_md5'");
	$r = mysql_fetch_array($s);
	$order_id = $r['id'];
	$status = $r['state1'];
}

if ( isset($_REQUEST['order']) ) {
	$s = sql("SELECT * FROM basket WHERE tmp_usr='$tmp_user_id'");
	if (mysql_num_rows($s) > 0) {
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
			 18, 'выделить', '', 0, 0, 0, $face_id, $face_rec_id, 0 )");
		$order_id = mysql_insert_id();   

		$order_sum_usd = 0;		
	
		$s = sql("SELECT b.*, d.brand, d.group_id, d.code, d.code_alt, d.descr, d.pr1, d.curr, b.descr as descr_rus
			 FROM basket b, detali d WHERE d.id=b.prod_id AND tmp_usr='$tmp_user_id'");
		while ($r = mysql_fetch_array($s)):
		   $r['descr'] = str_replace("'", "", $r['descr']);
		   $r['descr'] = str_replace("\\", "", $r['descr']);
		   $r['descr_rus'] = str_replace("'", "", $r['descr_rus']);
		   $r['descr_rus'] = str_replace("\\", "", $r['descr_rus']);

		   sql("INSERT INTO trans_inv (brand, group_id, code, code_alt, descr, pr1, pr2, trans_id, prod_id, curr, price, qty, status, descr_rus)
			 VALUES ($r[brand], $r[group_id], '$r[code]', '$r[code_alt]', '$r[descr]', $r[pr1], $r[price_usd], $order_id, $r[prod_id], 1,
				$r[price_usd], $r[qty], 1, '$r[descr_rus]')");
				
			$order_sum_usd = $order_sum_usd + ($r['price_usd'] * $r['qty']);	
		endwhile;
		
		$order_sum_rub = $order_sum_usd * $usd;
		$order_sum_euro = $order_sum_rub / $euro; 
		$order_sum_usd = str_replace(",", ".", $order_sum_usd);
		$order_sum_rub = str_replace(",", ".", $order_sum_rub);
		$order_sum_euro = str_replace(",", ".", $order_sum_euro);
		$order_md5 = md5($order_id); 
		
		sql ("UPDATE trans SET sum_order=$order_sum_usd, sum_order_euro=$order_sum_euro, sum_order_rub=$order_sum_rub, order_md5='$order_md5' WHERE id=$order_id");
		
		
		sql ("DELETE FROM basket WHERE tmp_usr='$tmp_user_id'");

		// отправляем на почту
		$message = '<html><head><title>Заказ из интернет магазина '.$site_name.'</title></head><body><p>Заказ из интернет магазина '.$site_name.'</p>';
		
		$s = sql("SELECT t.num, c.phone, c.email, c.adress, c.full_name FROM trans t, client c WHERE c.id=t.client AND t.id=$order_id");
		$r = mysql_fetch_array($s);
		$to = $r['email'];
                $message = '<div>Номер заказа: '.$r['num'].'</div>';
		$message .= '		
				<table cellpadding="2" cellmargin="0">                                
				<tr><td align="right">Клиент:</td><td>'.$r['full_name'].'</td></tr>
				<tr><td align="right">Телефон:</td><td>'.$r['phone'].'</td></tr>
				<tr><td align="right">Email:</td><td>'.$r['email'].'</td></tr>';

		$s = sql("SELECT * FROM client_deliv WHERE client_id=$user_id ORDER BY id DESC");
		if (mysql_num_rows($s) > 0) {
			$r = mysql_fetch_array($s);
			$message .= '<tr><td align="right">Получатель:</td><td>'.$r['name'].'</td></tr>';
			$message .= '<tr><td align="right">Индекс:</td><td>'.$r['zip_code'].'</td></tr>';
			$message .= '<tr><td align="right">Адрес доставки:</td><td>'.$r['adress'].'</td></tr>';				
		}		
		$message .= '</table>';
		
		$i = 1;
		$message .= '		
				<table cellpadding="2" cellmargin="0" border="1">
				<tr><th width="30"><small>н/н</small></th><th width="120"><small>код</small></th><th><small>описание</small></th>
					 <th width="80"><small>цена</small></th><th width="30"><small>кол</small></th><th width="80"><small>сумма</small></th></tr>';					
		$s = sql("SELECT code, descr, descr_rus, price, curr, qty FROM trans_inv WHERE trans_id=$order_id");
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
		$message .= '<br><br>Для оплаты перейдите на <a href="'.$site_url.'/orderpay.html?pay='.$order_md5.'">страницу оплаты заказа</a><br><br><br>';
		$message .= '</body></html>'; 

		$subject = "Заказ из интернет магазина $site_name"; 
		$headers  = "Content-type: text/html; charset=utf-8 \r\n"; 
		$headers .= "From: $site_mail\r\n"; 

		mail($to, $subject, $message, $headers); 
		//$subject = "Заказ $site_name"; 
                $subject = "Новый заказ";
		mail('atmyspace@yahoo.com', $subject, $message, $headers);	
	}
}


$tpl -> define(array('orderpay' => "orderpay.tpl"));
$tpl -> define_dynamic ( "order_done", "orderpay" );


$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li><li class="active">Оплата заказа</li>';	

if ($order_id == 0 or $status > 0) {
        $content = '<div class="alert alert-error"><h4 class="alert-heading">Ошибка!</h4> Заказа не существует или он уже оплачен!</div>';
        if ($user_id > 0) {
                $back = '<a href="{_SITE_}/orders.html" role="button" class="btn btn-large btn-inverse" ><i class="icon-arrow-left icon-white"></i> Назад </a>';
        } else {
                $back = '<a href="{_SITE_}/" role="button" class="btn btn-large btn-inverse" ><i class="icon-arrow-left icon-white"></i> Назад </a>';
        }
        $tpl -> clear_dynamic ( "order_done" );
} else {
        $s = sql("SELECT num, sum_order_rub, order_md5 FROM trans WHERE id=$order_id");
        $r = mysql_fetch_array($s);
        $md5_id = $r['order_md5'];
        $content = 'Заказ <b>№ '.$r['num'].' </b> успешно оформлен.<br>';
        $content .= 'Итого к оплате: <b>'.number_format($r['sum_order_rub'], 2, '.', ' ').' руб.</b>';

        $prim = '';
        $s2 = sql("SELECT * FROM site_template WHERE id=4");
        $r2 = mysql_fetch_array($s2);
        if ($r2['page_content'] != '') {
                $prim = '<br><br><div class="alert alert-info"><a class="close" data-dismiss="alert">×</a><strong>'.$r2['page_header'].'</strong> '.$r2['page_content'].'</div>';  
        }
        $s2 = sql("SELECT * FROM site_template WHERE id=5");
        $r2 = mysql_fetch_array($s2);
        if ($r2['page_header'] != '') {
                $card_num = $r2['page_header'];  
        }	
        if ($r2['page_content'] != '') {
                $card_info = $r2['page_content'];   
        }		
        $tpl -> assign( array('prim' => $prim, 'card_num' => $card_num, 'card_info' => $card_info, 'id' => $md5_id) );	

        $back = '';
        $tpl -> parse('ORDER_DONE', ".order_done");
}

$tpl -> assign( array('h1' =>  $h1,
                  'navigate' => $navigate,
                                          'content' => $content,
                                          'back' => $back
                   ));

$tpl->parse('MAIN', "orderpay");
$tpl_main = $tpl -> get_assigned('MAIN');
?>