<?php

$id = $state_value;
if ($id <= 0 ):
   @header('location: '.$site_url.'/orders.html') and exit();
else:
  $s = sql("SELECT client FROM trans WHERE id=$id");
  $r = mysql_fetch_array($s);
  if ($r['client'] != $user_id):
    @header('location: '.$site_url.'/orders.html') and exit();
  endif;
endif;

$tpl -> define( array(order => "order.tpl"));



  $s = sql("SELECT note, num FROM trans WHERE id=$id");
  $r = mysql_fetch_array($s);
  $tpl -> assign( array(note   => stripslashes($r['note']) ));
  $num = $r['num'];
  
$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
			 <li><a href="'.$site_url.'/orders.html">Список заказов</a> <span class="divider">/</span></li>
			<li class="active">Заказ №'.$num.'</li>';  

  $tpl -> define_dynamic ( "trn_row", "order" );
  $j = 1;
  $total_pay_sum = 0;
  $s = sql("SELECT concat(tc.name, ' № ', t.num, ' от ', DATE_FORMAT(t.t_date,'%d.%m.%Y')) as name,
                  sum_accaunt, usd, t.t_type
             FROM trans t
             LEFT JOIN transclass tc ON tc.t_type=t.t_type AND tc.t_class=t.t_class
             WHERE t.t_type IN (3,4) AND t.t_back=$id");
  if (mysql_num_rows($s)>0):
      while ($r = mysql_fetch_array($s)):
         $j ++;
         if ($j==2): $bg = '#48535b'; $j =0; else: $bg='#37434a'; endif;

         $pay_sum = round($r['sum_accaunt'] * $r['usd'], 2);
         if ($r['t_type'] == 4): $pay_sum = 0 - $pay_sum ; endif;
         $tpl -> assign( array( pay_trn => $r['name'],
                                pay_sum => number_format($pay_sum, 2, '.', ' '),
                                bg    => $bg
                          ));
         
         $tpl -> parse(TRN_ROW, ".trn_row");
         $total_pay_sum = $total_pay_sum + $pay_sum;
      endwhile;
  else:
          $tpl -> clear_dynamic ( "trn_row" );
  endif;

  $tpl -> assign( array(total_pay_sum => number_format($total_pay_sum, 2, '.', ' ') ));


///////////  ОТГРУЗКА
  $tpl -> define_dynamic ( "ship_row", "order" );
  $j = 1;
  $total_ship_sum = 0;
  $s = sql("SELECT concat(tc.name, ' № ', t.num, '/', t.num2, ' от ', DATE_FORMAT(t.t_date,'%d.%m.%Y')) as name,
                  sum_ship_rub, t.t_type, t.deliv, t.deliv_num
             FROM trans t
             LEFT JOIN transclass tc ON tc.t_type=t.t_type AND tc.t_class=t.t_class
             WHERE t.t_type IN (1) AND t.t_back=$id");
  if (mysql_num_rows($s)>0):
      while ($r = mysql_fetch_array($s)):
         $j ++;
         if ($j==2): $bg = '#48535b'; $j =0; else: $bg='#37434a'; endif;
         switch ($r['deliv']) {
           case 1: $deliv = 'Самовывоз из офиса.';  break;
           case 2: $deliv = 'Доставка: Почта России';  
              if ($r['deliv_num'] != ''): $deliv .= '. Почтовое отправление №<a href="http://www.russianpost.ru/resp_engine.aspx?Path=rp/servise/ru/home/postuslug/trackingpo" target="_blank">'.$r['deliv_num'].'</a>.'; endif;
              break;
           case 3: $deliv = 'Доставка: EMS Почта России';  
              if ($r['deliv_num'] != ''): $deliv .= '. Почтовое отправление №<a href="http://www.emspost.ru/tracking/'.$r['deliv_num'].'" target="_blank">'.$r['deliv_num'].'</a>.'; endif;
              break;
           default: $deliv = 'Самовывоз из офиса.'; break;
         }
         $ship_sum = $r['sum_ship_rub'];
         $tpl -> assign( array( ship_trn => $r['name'],
                                ship_sum => number_format($ship_sum, 2, '.', ' '),
                                deliv => $deliv
                          ));
         
         $tpl -> parse(SHIP_ROW, ".ship_row");
         $total_ship_sum = $total_ship_sum + $ship_sum;
      endwhile;
  else:
		  $tpl -> clear_dynamic ( "ship_row" );
  endif;
  $tpl -> assign( array(total_ship_sum => number_format($total_ship_sum, 2, '.', ' ') ));
 
 
///////////
  $tpl -> define_dynamic ( "order_row", "order" );
  $total_qty = 0; $total_sum = 0;
  $j = 1;
  $s = sql("SELECT ti.id, ti.code, ti.descr_rus, ti.price, t.usd, qty,
               (SELECT ds.name FROM detalstatus ds WHERE ds.id=ti.status) as status
            FROM trans_inv ti, trans t WHERE t.id=ti.trans_id AND trans_id=$id ORDER BY code");

  if (mysql_num_rows($s)>0):
    while ($r = mysql_fetch_array($s)):
          //echo $r['price'] .' -> '. $r['usd']. ' -> '. myround($r['price']).   '<br>';
          $price = round($r['price'] * $r['usd'], 2);
          $qty = $r['qty'];
          $sum = $price * $qty;

          $status = '<a href="#none" onClick="showModal(\''.$r['id'].'\');">'.$r['status'].'</a>';

          $tpl -> assign( array(code   => stripslashes($r['code']),
                                descr  => stripslashes($r['descr_rus']),
                                price  => number_format($price, 2, '.', ' '),
                                qty    => $qty,
                                sum    => number_format($sum, 2, '.', ' '),
                                status => $status
                                ));
          $tpl -> parse(ORDER_ROW, ".order_row");
    
          $total_qty = $total_qty + $qty;
          $total_sum = $total_sum + $sum;
    endwhile;
  else:
          $tpl -> assign( array(code   => '&nbsp;',
                                descr  => '&nbsp;',
                                price  => '&nbsp;',
                                qty    => '&nbsp;',
                                sum    => '&nbsp;',
                                status => '&nbsp;'
                                ));
          $tpl -> parse(ORDER_ROW, ".order_row");
  endif;
  
$tpl -> define_dynamic ( "no_pay", "order" );
if ($total_sum > $total_pay_sum):
	$tpl -> parse(NO_PAY, ".no_pay");
else:
	$tpl -> clear_dynamic ( "no_pay" );
endif;
  
	$order_md5 = md5($id);
    $tpl -> assign( array(total_qty => $total_qty,
                          total_sum  => number_format($total_sum, 2, '.', ' '),
                          h1 =>  'Просмотр заказа №'.$num,
                          navigate => $navigate,
                          pay_id => $order_md5
                           ));


$tpl->parse(MAIN, "order");
$tpl_main = $tpl -> get_assigned(MAIN);
?>