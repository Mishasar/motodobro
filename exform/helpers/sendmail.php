<?php
/**
 *
 * mForm v1.0
 * Lopulyak Oleg < ol_lo@ukr.net >
 * Created 10.02.2013
 * 
 */
if (!isset($_REQUEST["mf_path"]) && !isset($_REQUEST["mf_captcha_code"])) die("Restricted access");
$to = $config->mail;
$subject = $config->mail_subject;
$headers = 	"From: ".$config->mail_from."\r\n".
			'X-Mailer: PHP/'.phpversion()."\r\n".
			"MIME-Version: 1.0\r\n".
			"Content-Type: text/html; charset=utf-8\r\n".
			"Content-Transfer-Encoding: 8bit\r\n\r\n";
$mail_status = mail($to, "=?utf-8?B?".base64_encode($subject)."?=", $message, $headers);
?>
