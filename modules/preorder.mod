<?php

if ( isset($_REQUEST['adress']) ) {
   $d_name = mysql_escape_string ($_REQUEST['d_name']);
   $d_zip = mysql_escape_string ($_REQUEST['d_zip']);   
   $d_adress = mysql_escape_string ($_REQUEST['d_adress']);	
   $d_pasport = mysql_escape_string ($_REQUEST['d_pasport']);	
    //id, name, zip_code, adress, edit_date 
    $s = sql("SELECT id FROM client_deliv WHERE client_id=$user_id /*AND name='$d_name' AND adress='$d_adress'*/");  
    $r = mysql_fetch_array($s);	
    if ($r['id'] > 0) {
            sql("UPDATE client_deliv SET edit_date=NOW(), zip_code='$d_zip', name='$d_name', adress='$d_adress', pasport='$d_pasport' WHERE id=".$r['id']);
    } else {
            sql("INSERT INTO client_deliv (name, zip_code, adress, edit_date, client_id, pasport ) VALUES ('$d_name', '$d_zip', '$d_adress', NOW(), $user_id, '$d_pasport')");
    }		
}
	
$title = 'Ваш заказ';
$h1 = $title;
$meta_key = '';
$meta_descr = '';
$page_title = $title;
$page_key = $title;

$tpl -> define(array('preorder' => "preorder.tpl"));
$tpl -> define_dynamic ( "order_row", "preorder" );

$s = sql("SELECT b.*, d.code, d.descr as en_descr
         FROM basket b 
         LEFT JOIN detali d ON d.id=b.prod_id WHERE tmp_usr='$tmp_user_id'");

$total_sum = 0; $i = 0;
$j =0;

  while ($r = mysql_fetch_array($s)):
     $sum = $r['price'] * $r['qty'];
        $tpl -> assign( array('id'    => $r['prod_id'],
                              'code'     => addslashes($r['code']),
                              'descr'     => $r['descr'],
							  'qty'     => $r['qty'],
                              'sum'    => number_format($sum, 2, '.', ' ')     
                              ));
        $tpl -> parse('ORDER_ROW', ".order_row");

      $total_sum = $total_sum + $sum;
      $i ++;
  endwhile;
  
//id, name, zip_code, adress, edit_date  
$s2 = sql("SELECT * FROM client_deliv WHERE client_id=$user_id ORDER BY id DESC");  
$r2 = mysql_fetch_array($s2);
$d_name = $r2['name'];
$d_zip = $r2['zip_code'];
$d_adress = $r2['adress'];
$d_pasport = $r2['pasport'];

	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li><li class="active">Ваш заказ</li>';	
	
    $tpl -> assign( array('navigate' => $navigate,
                            'total_sum'  => number_format($total_sum, 2, '.', ' '),
                            'd_name' => $d_name,
                            'd_zip' => $d_zip,
                            'd_adress' => $d_adress,
                            'd_pasport' => $d_pasport
                           ));

  $tpl->parse('MAIN', "preorder");
  $tpl_main = $tpl -> get_assigned('MAIN');
?>