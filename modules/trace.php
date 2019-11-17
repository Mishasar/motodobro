<?php
include('../includes/cls_fast_template.php');
include_once ('../init.inc');
$tpl = new FastTemplate("../templates/");
$tpl -> define( array( main  => "trace.tpl"));

$id = $_REQUEST['id'];
$s = sql ("SELECT code, descr_rus, qty FROM trans_inv WHERE id=$id");
$r = mysql_fetch_array($s);
$tpl -> assign( array(d_code => $r['code'], d_descr => $r['descr_rus'], d_qty => $r['qty'] ));


$tpl -> define_dynamic ( "order_row", "main" );

$s = sql("SELECT CONCAT(tc.name, ' №', IF(num2='', num, num2), ' от ', DATE_FORMAT(t.t_date, '%d.%m.%Y') ) as name, qty
            FROM trans t, trans_ins_sub tis, transclass tc
            WHERE tis.trans_id=t.id AND tc.t_type=t.t_type AND tc.t_class=t.t_class AND tis.prod_id=$id
          UNION
          SELECT CONCAT(tc.name, ' №', num, '/', num2, ' от ', DATE_FORMAT(t.t_date, '%d.%m.%Y') ) as name, qty
            FROM trans t, trans_ins ts, transclass tc
            WHERE ts.trans_id=t.id AND tc.t_type=t.t_type AND tc.t_class=t.t_class AND t.t_type=1 AND t.t_class=3 AND ts.prod_id=$id");

if (mysql_num_rows($s)>0):
  while ($r = mysql_fetch_array($s)):
     $tpl -> assign( array(trans   => $r['name'], qty => $r['qty'] ));
     $tpl -> parse(ORDER_ROW, ".order_row");
  endwhile;
else:
     $tpl -> assign( array(trans   => '&nbsp;', qty => '&nbsp;' ));
     $tpl -> parse(ORDER_ROW, ".order_row");
endif;
$tpl->parse(MAIN, "main");
$tpl->FastPrint();
?>