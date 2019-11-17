<?php
header("Content-type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
include_once('../init.inc');

if (isset($_REQUEST['id'])): $id = $_REQUEST['id']; else: $id = 0; endif;
if (isset($_REQUEST['input01'])): $pdate = $_REQUEST['input01']; else: $pdate = ''; endif;
if (isset($_REQUEST['input02'])): $psum = $_REQUEST['input02']; else: $psum = ''; endif;
if (isset($_REQUEST['input03'])): $pname = $_REQUEST['input03']; else: $pname = ''; endif;
$s = sql("SELECT t.num, full_name, email, phone, sum_order_rub, t_date FROM trans t, client c WHERE c.id=t.client AND t.order_md5='$id'");
$r = mysql_fetch_array($s);
$num = $r['num'];

$mail_header = "MIME-Version: 1.0\r\n" . "Content-Type: text/plain; charset=\"utf-8\"\r\n" ."From: ".$site_mail."\r\n";

$message  = "Подтверждение оплаты по заказу #".$num." от ".strftime("%d.%m.%Y", strtotime($r['t_date']))."\n";
$message .= "Дата отправки: ".date("d.m.Y H:i:s")." \n\n";
$message .= "Покупатель: " . $r['full_name'] . "\n";
$message .= "Телефон: " . $r['phone'] . "\n";
$message .= "E-mail: " . $r['email'] . "\n";
$message .= "Сумма заказа: " .number_format($r['sum_order_rub'], 2, '.', ' '). "\n\n";
$message .= "Дата оплаты: " . $pdate . "\n";
$message .= "Сумма оплаты: " . $psum . "\n";
$message .= "Плательщик: " . $pname . "\n\n\n";		

mail('saraykin1996@gmail.com', $site_name.": Подтверждение оплаты по заказу", $message, $mail_header);
mail('atmyspace@yahoo.com', $site_name.": Подтверждение оплаты по заказу", $message, $mail_header);


?>