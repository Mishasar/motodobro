<?php
$tpl -> define( array(orders => "orders.tpl"));
$tpl -> define_dynamic ( "order_row", "orders" );


$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
				<li class="active">Личный кабинет</li>';	


$total_zak = 0; $total_opl = 0; $total_otg = 0; $total_no_opl = 0;
$j = 1;

$s = sql("SELECT id, num, t_date, sum_order_rub, ROUND(sum_accaunt * usd, 2) as sum_accaunt, sum_ship_rub,
           (SELECT name FROM transstatus WHERE status_id=state1 AND status_type=1) as s1,
           (SELECT name FROM transstatus WHERE status_id=state2 AND status_type=2) as s2,
           (SELECT name FROM transstatus WHERE status_id=state3 AND status_type=3) as s3
         FROM trans t WHERE t_type=1 AND t_class=1 AND client=$user_id  ORDER BY num DESC");
         
if (mysql_num_rows($s)>0):
  while ($r = mysql_fetch_array($s)):
        $zak = $r['sum_order_rub'];
        $opl = $r['sum_accaunt'];
        $no_opl = $zak - $opl;
        $otg = $r['sum_ship_rub'];
		if ($zak > $opl):
			$s1k = '<div class="pull-right"><form action="'.$site_url.'/orderpay_.html" method="post" style="padding:0px; margin:0px;" target="_blank">
				 <input type="submit" name="update" value="Оплатить заказ" class="btn btn-small btn-inverse">
				 <input name="pay" value="'.md5($r['id']).'" type="hidden">
				</form></div>';
		else:
			$s1k = '';
		endif;	
 
        $tpl -> assign( array(id     => $r['id'],
                              num     => $r['num'],
                              s_date => strftime("%d.%m.%Y", strtotime($r['t_date'])),
                              s1     => $r['s1'],
							  s1k	 => $s1k,
                              s2     => $r['s2'],
                              s3     => $r['s3'],
                              zak    => number_format($zak, 2, '.', ' '),
                              opl    => number_format($opl, 2, '.', ' '),
                              otg    => number_format($otg, 2, '.', ' '),
                              code   => $code
                              ));
        $tpl -> parse(ORDER_ROW, ".order_row");
  
        $total_zak = $total_zak + $zak;
        $total_opl = $total_opl + $opl;
        $total_otg = $total_otg + $otg;
  endwhile;
else:
  $tpl -> clear_dynamic ( "order_row" );
endif;

    $tpl -> assign( array(total_zak  => number_format($total_zak, 2, '.', ' '),
                          total_opl  => number_format($total_opl, 2, '.', ' '),
                          total_no_opl  => number_format($total_no_opl, 2, '.', ' '),
                          total_otg  => number_format($total_otg, 2, '.', ' '),
                          h1 =>  'Мои заказы',
                          navigate => $navigate,
                           ));


$tpl->parse(MAIN, "orders");
$tpl_main = $tpl -> get_assigned(MAIN);
?>