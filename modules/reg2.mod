<?php

require_once "recaptchalib.php";

$title = 'Запчасти для мотоциклов и квадроциклов. Запчасти для гидроциклов, снегоходов катеров.';
$meta_key = 'запчасти для мотоциклов, квадроциклов, запчасти для гидроциклов, снегоходов, катеров';
$meta_descr = 'Запчасти для мотоциклов и квадроциклов.';

$tpl -> define(array('index' => "reg2.tpl"));

$ok = ''; $msg = '';
if(isset($_REQUEST['enter']) ) {
	mb_internal_encoding("UTF-8");
		
	$secret = "6Ldo4TkUAAAAAJH0BlvQvUNYnEQuhvuAbsfdxkpZ";		 
	$response = null;		 
	$reCaptcha = new ReCaptcha($secret);
		
	if ($_POST["g-recaptcha-response"]) {
		$response = $reCaptcha->verifyResponse($_SERVER["REMOTE_ADDR"],$_POST["g-recaptcha-response"]);
	}
	
	if ($response == null || !$response->success) {
		$msg = '<div class="alert alert-block"> <h4>Внимание!</h4> Ваши данные не прошли проверку!</div>';
	}
	else{		
		$name = isset($_REQUEST['name']) ? trim($_REQUEST['name']) : '';  $name = mb_convert_case($name, MB_CASE_TITLE, "UTF-8");
		$phone = isset($_REQUEST['phone']) ? $_REQUEST['phone'] : '';
		$mail = isset($_REQUEST['mail']) ? $_REQUEST['mail'] : "";

		if ($name=="" || $phone=="" || $mail=="") {
			$msg = '<div class="alert alert-block"> <h4>Внимание!</h4> Все поля формы должны быть заполнены!</div>';
		} else { 
			$s = sql("SELECT COUNT(*) FROM client WHERE email='".addslashes($mail)."'");
			$r = mysql_fetch_array($s);
			if($r[0]>0) {
					$msg = '<div class="alert alert-block"> <h4>Внимание!</h4> Пользователь с таким e-mail уже существует!<br>Если Вы забыли реквизиты доступа, воспользуйтесь <a href="'.$site_url.'/restore_.html">формой восстановления пароля</a></div>';
			} else {
					$ok = 'ok';	
			}	
		}
	}
	
	if($ok == 'ok') {
		//Задаем длину пароля
		$length = 8;
		//Массив символов, из которых будет генерироваться пароль
		$arr = array('q', 'w', 'e', 'r', 't', 'y',
		'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h',
		'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm',
		'Q', 'W', 'E', 'R', 'T', 'Y','U', 'I', 'O', 'P',
		'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L',
		'Z', 'X', 'C', 'V', 'B', 'N', 'M',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
		//Инициализация переменой, которая будет содержать пароль
		$pwd = '';
		//Генерация пароля
		for ($i = 0; $i < $length; $i++){
			$index = rand(0, count($arr) - 1);
			$pwd .= $arr[$index];
		}		
		sql("INSERT INTO client (name, phone, email, adress, note, group_id, full_name, psw, form, juradress, c_import, r_int) VALUES
		   ('".addslashes($name)."', '".addslashes($phone)."', '".addslashes($mail)."', NULL, NULL, 1, '".addslashes($name)."', '".addslashes($pwd)."', ' ', NULL, 1, 1)");
		
		$last_id = mysql_insert_id(); 

		$s = sql("SELECT id, psw, email, name, phone FROM client WHERE id=$last_id");
		$r = mysql_fetch_array($s);		

		$tpl -> define(array('index' => "reg2_ok.tpl"));
		$tpl -> assign( array(  'mail' => $r['email']));
		$tpl->parse('MAIN', "index");
		$tpl_main = $tpl -> get_assigned('MAIN');

        $login = $r['email'];
        $pass = $r['psw'];


        $link = '<a href="http://www.motodobro.ru/parts/orders.html?login='.$login.'&pass='.$pass.'">Для входа в личный кабинет, перейдите по этой ссылке</a>';



		$mail_header = "MIME-Version: 1.0\r\n" . "Content-Type: text/html; charset=\"utf-8\"\r\n" .
					"From: ".$site_mail."\r\n";
		$message  = "Уважаемый " . $r['name'] . "!<br><br>";
		$message .= "Вы зарегистрировались на сайте ".$site_name." <br>";

        $message .= $link." <br>";


		$message .= "Ваш логин: " . $r['email'] . "<br>";
		$message .= "Ваш пароль: " .$r['psw']. "<br><br>";
		$message .= "Спасибо за интерес проявленный к нашему интернет-магазину! <br>";
		$message .= "С уважением, Администрация ".$site_name.". <br>";
		mail($mail, $site_name.": Регистрация на сайте", $message, $mail_header);

		$mail_header2 = "MIME-Version: 1.0\r\n" . "Content-Type: text/plain; charset=\"utf-8\"\r\n" .
					"From: ".$site_mail."\r\n";
		
		$message  = "На сайте зарегистрирован новый клиент!\n\n";
		$message .= "Время регистрации: ".date("d.m.Y H:i:s")." \n";
		$message .= "Имя: " . $r['name'] . "\n";
		$message .= "Телефон: " . $r['phone'] . "\n";
		$message .= "E-mail: " . $r['email'] . "\n";
		$message .= "Пароль: " .$r['psw']. "\n\n";			
		mail('atmyspace@yahoo.com', $site_name.": Регистрация клиента", $message, $mail_header2);
	} 
	else {
		$tpl -> assign( array( 'name' => $name, 'phone' => $phone, 'mail' => $mail, 'MSG' => $msg, 'hidereg' => '', 'hideauth' => 'hidden' ));	
	}		
} 
else {		
	$tpl -> assign( array( 'name' => '', 'phone' => '', 'mail' => '', 'MSG' =>  '', 'hidereg' => 'hidden', 'hideauth' => '', 'auth_form_action' => $site_url.'/basket.html' ));		
}

if ($ok != 'ok'){
	$tpl->parse('MAIN', "index");
	$tpl_main = $tpl -> get_assigned('MAIN');
}
?>