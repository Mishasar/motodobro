<?php
header("Content-type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
session_start();
include_once('../init.inc');
$tmp_user_id = user_track();

	$s = sql("SELECT SUM(qty), SUM(qty*price) FROM basket WHERE tmp_usr='$tmp_user_id'");
	$r = mysql_fetch_array($s);
	if ($r[0] > 0):
		echo '<table width="100%">
						<tr><td align="left">В корзине: '.number_format($r[0], 0).' шт.<br>На сумму: '.number_format($r[1], 2, '.', ' ').'р</td>
						</tr>
						<tr><td ><a href="/basket.html" class="btn btn-info "><i class="icon-shopping-cart icon-white"></i> Перейти в корзину</a></td>
						</tr>
						</table>';
	else:
		echo '<i class="icon-shopping-cart"></i> Корзина пуста';	
	endif;
?>