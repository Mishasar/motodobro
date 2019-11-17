<?php
session_start();
include_once('../init.inc');
$tmp_user_id = user_track();
if (isset($_REQUEST['add'])):
   $prod_id = $_REQUEST['id'];
   $price = str_replace(",", ".", $_REQUEST['price']);
   $price_usd = str_replace(",", ".", $_REQUEST['price_usd']);
   $qty = $_REQUEST['qty'];
   $descr = $_REQUEST['descr'];
   
   // проверяем замены
   $s = sql("SELECT code_ref, group_id, code FROM detali WHERE id=$prod_id");
   $r = mysql_fetch_array($s);
   $code_ref = $r['code_ref'];
   if ($code_ref != ''):
     $group_ref = $r['group_id'];
     $descr = "(ст. код " . $r['code'] . ") " . $descr;
         $i = 0;
         while ($code_ref != ''):
             $i ++;
             $s_ref = sql("SELECT pr1, pr2, id as d_id, code_ref FROM detali WHERE code='".$code_ref."' AND group_id=".$r['d_group']);
             $r_ref = mysql_fetch_array($s_ref);
             $code_ref = $r_ref['code_ref'];
             if ($i > 3): break; endif;
         endwhile;
         $r['pr1'] = $r_ref['pr1'];
         $r['pr2'] = $r_ref['pr2'];
         $r['id'] = $r_ref['d_id'];

     if ($r['id'] > 0):
       $prod_id = $r['id'];

       // поиск формулы расчета цены
		  $s2 = sql("SELECT value FROM price p WHERE p.client_gr=15 AND p.prod_gr=$group_ref");
		  $r2 = mysql_fetch_array($s2);
		  $formula = $r['value'];
       // расчет цены
       if ($formula <> ''):
          $formula = str_replace("pr1", $r['pr1'], $formula);
          $formula = str_replace("PR1", $r['pr1'], $formula);
          $formula = str_replace("pr2", $r['pr2'], $formula);
          $formula = str_replace("PR2", $r['pr2'], $formula);
          $formula = str_replace(",", ".", $formula);
          eval("\$price=". $formula .";");
       else:
          $price = $r['pr2'];
       endif;

       // если евро - переводим в доллары
       $s = sql("SELECT value FROM currency_value WHERE curr_id=1 ORDER BY c_date DESC LIMIT 1");
       $r = mysql_fetch_array($s);
       $usd = $r['value'];
       $s = sql("SELECT value FROM currency_value WHERE curr_id=2 ORDER BY c_date DESC LIMIT 1");
       $r = mysql_fetch_array($s);
       $euro = $r['value'];
       if ($r['curr'] == 2):
          $price = round($price * ($euro/$usd), 2);
       endif;
       $price_usd = $price;
       $price = $price * $usd;
     endif;
   endif;

   $s = sql("SELECT * FROM basket WHERE tmp_usr='$tmp_user_id' AND prod_id=$prod_id");
   if (mysql_num_rows($s) == 0):
      sql("INSERT INTO basket (client, prod_id, price, price_usd, qty, descr, tmp_usr) VALUES
            (0, $prod_id, $price, $price_usd, $qty, '$descr', '$tmp_user_id')");
   else:
      sql("UPDATE basket SET qty=qty+$qty WHERE tmp_usr='$tmp_user_id' AND prod_id=$prod_id");
   endif;
endif;
?>