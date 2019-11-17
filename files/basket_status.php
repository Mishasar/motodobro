<?php
header("Content-type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
session_start();
include_once('../init.inc');
$tmp_user_id = user_track();

   $total_sum = 0;	$i = 0;
   $s = sql("SELECT * FROM basket WHERE tmp_usr='$tmp_user_id'");
   while ($r = mysql_fetch_array($s)):
		$sum = $r['price'] * $r['qty'];
		$total_sum += $sum;
		$i ++;		
   endwhile;
   echo 'В Вашей корзине товаров: '.$i.' шт. на сумму '.number_format($total_sum, 2, '.', ' ').'р';
	echo '<br>'.$_REQUEST['ran'];
?>