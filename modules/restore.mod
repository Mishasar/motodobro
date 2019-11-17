<?php
  $title = 'Запчасти для мотоциклов и квадроциклов. Запчасти для гидроциклов, снегоходов катеров.';
  $meta_key = 'запчасти для мотоциклов, квадроциклов, запчасти для гидроциклов, снегоходов, катеров';
  $meta_descr = 'Запчасти для мотоциклов и квадроциклов.';


  
//Проверяем картинку
function acc_img() {
   $err_mess = '';
   $ip = $_SERVER['REMOTE_ADDR'];
   $forward = getenv(HTTP_X_FORWARDED_FOR);
   if (!empty($forward) && ($forward != $_SERVER['REMOTE_ADDR']))  $ip = $ip."/".$forward;
   
   if (!$_REQUEST['secret']): $err_mess = '<div class="alert alert-error">Вы не ввели секретный код</div>'; endif;
   if (!empty($_REQUEST['secret'])):
      $s = sql("SELECT * FROM reg WHERE ip LIKE '%".$ip."%'");
      $r = mysql_fetch_array($s);
      if (sha1($_REQUEST['secret']) != $r['data']):
          $err_mess = '<div class="alert alert-error">Число которое вы ввели не совпадает с числом на картинке.</div>';
      else:
          sql("DELETE FROM reg WHERE ip LIKE '%".$ip."%'");
      endif;
   endif;
   return $err_mess;
}

//  Проверяем почту
function CheckEmail($Email)
{
    if(filter_var($Email, FILTER_VALIDATE_EMAIL)){ return true; }
        else return false;
	/*	
	if (!preg_match("/^[\._a-zA-Z0-9-]+@[\.a-zA-Z0-9-]+\.[a-z]{2,6}$/", $Email)) return false;
    list($Username, $Domain) = explode("@",$Email);
    if (@getmxrr($Domain, $MXHost)) return true;
    else
    {
        $f=@fsockopen($Domain, 25, $errno, $errstr, 30);
        if($f)
        {
            fclose($f);
            return true;
        }
        else return false;
    }
	*/
}

$msg = '';
$mail = '';
$code = '';

if ( isset($_REQUEST['enter']) ):
     $mail = $_REQUEST['mail'];
	 $code = $_REQUEST['code'];
	 require 'exform/captcha/securimage.php';
     $securimage = new Securimage();
	 if($securimage->check($code) == false): $msg = 'Неверный код!'; else: $msg = '';  endif;
  if ($msg == ''):
      if (CheckEmail($mail)):
         $s = sql("SELECT id, name, psw, email FROM client WHERE group_id=1 AND email='$mail'");
         $r = mysql_fetch_array($s);
         if ($r['psw']!=''):
            $mail_header = "MIME-Version: 1.0\r\n" . "Content-Type: text/plain; charset=\"utf-8\"\r\n" .
                        "From: ".$site_mail."\r\n";
            $message  = "Уважаемый " . $r['name'] . "!\n\n";
            $message .= "Вы воспользовались формой восстановления пароля на сайте ".$site_name." \n";
            $message .= "Ваш логин: " . $r['email'] . "\n";
            $message .= "Ваш пароль: " .$r['psw']. "\n\n";
            $message .= "Спасибо за интерес проявленный к нашему интернет-магазину! \n";
            $message .= "С уважением, Администрация ".$site_name.". \n";
            mail($mail, $site_name.": Восстановление пароля", $message, $mail_header);

            $tpl -> define(array(index => "restore_ok.tpl"));
            $tpl -> assign( array( mail => $mail ));
         else:
             $msg = '<div class="alert alert-error">Пользователя с таким e-mail не существует!</div>';
             $tpl -> define(array(index => "restore.tpl"));
             $tpl -> assign( array( mail => $mail, msg => $msg, code => $code ));           
         endif;
      else:
         $msg = '<div class="alert alert-error">Неверно введен адрес e-mail</div>';
         $tpl -> define(array(index => "restore.tpl"));
         $tpl -> assign( array( mail => $mail, msg => $msg, code => $code ));      
      endif;
  else:
     $tpl -> define(array(index => "restore.tpl"));
     $tpl -> assign( array( mail => $mail, msg => $msg, code => $code ));
  endif;
else:
  $tpl -> define(array(index => "restore.tpl"));
  $tpl -> assign( array( mail => $mail, msg => $msg, code => $code ));
endif;

  
  
  $tpl->parse(MAIN, "index");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>