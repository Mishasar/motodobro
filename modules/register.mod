<?php
  $title = 'Запчасти для мотоциклов и квадроциклов. Запчасти для гидроциклов, снегоходов катеров.';
  $meta_key = 'запчасти для мотоциклов, квадроциклов, запчасти для гидроциклов, снегоходов, катеров';
  $meta_descr = 'Запчасти для мотоциклов и квадроциклов.';

  $tpl -> define(array(index => "register.tpl"));
  $tpl -> assign( array( active_fiz => 'active', active_jurr => ''));

if(isset($_REQUEST['enter']) ):
 if($_REQUEST['face'] == "jurr"):
   $tpl -> assign( array( active_fiz => '', active_jurr => 'active'));
  else:
   $tpl -> assign( array( active_fiz => 'active', active_jurr => ''));
 endif;
 
 mb_internal_encoding("UTF-8");
 $f_name = trim($_REQUEST['f_name']);  $f_name = mb_convert_case($f_name, MB_CASE_TITLE, "UTF-8");
 $m_name = trim($_REQUEST['m_name']);  $m_name = mb_convert_case($m_name, MB_CASE_TITLE, "UTF-8");
 $l_name = trim($_REQUEST['l_name']);  $l_name = mb_convert_case($l_name, MB_CASE_TITLE, "UTF-8");
 $b_name = $l_name .' '. mb_substr($f_name, 0, 1) .'.'. mb_substr($m_name, 0, 1) .'.';
 $b_full_name = $l_name .' '. $f_name .' '. $m_name;

  $phone = $_REQUEST['phone'];
  $mail = $_REQUEST['mail'];
  $index = $_REQUEST['index'];
  $addr = $_REQUEST['addr'];
  $comment = $_REQUEST['comment'];
  $pwd = $_REQUEST['pwd'];
  $pwd_re = $_REQUEST['pwd_re'];
  
  $name = $_REQUEST['name'];
  $form = $_REQUEST['form'];
  $inn = $_REQUEST['inn'];
  $kpp = $_REQUEST['kpp'];
  $rass = $_REQUEST['rass'];
  $bank = $_REQUEST['bank'];
  $bik = $_REQUEST['bik'];
  $kors = $_REQUEST['kors'];
  $juradress = $_REQUEST['juradress'];
  $code = $_REQUEST['code'];
  

  if($_REQUEST['face'] == "fiz"):
   $ok = '';
   if ($f_name=="" || $m_name=="" || $l_name=="" || $phone=="" || $mail=="" || $index == "" || $addr=="" || $pwd=="" || $pwd_re=="" || $code==""): 
    $msg = 'Внимание! Все поля формы должны быть заполнены!';
   else: 
	$s = sql("SELECT COUNT(*) FROM client WHERE group_id=1 AND email='".addslashes($mail)."'");
    $r = mysql_fetch_array($s);
    if($r[0]>0):
      $msg = 'Внимание! Пользователь с таким e-mail уже существует!<br>Если Вы забыли реквизиты доступа, воспользуйтесь
      <a href="'.$site_url.'/restore_.html">формой восстановления пароля</a>';
    else:
    
	 require 'exform/captcha/securimage.php';
     $securimage = new Securimage();
	 if($securimage->check($code) == false) $msg = 'Неверный код!'; else $ok = 'ok';
 
    endif;
   endif;
	 
   if($ok == 'ok'):

    sql("INSERT INTO client (name, phone, email, adress, note, group_id, full_name, psw, form, juradress, c_import, r_int) VALUES
               ('".addslashes($b_name)."', '".addslashes($phone)."',
                '".addslashes($mail)."', '".addslashes($index)." ".addslashes($addr)."',
                '".addslashes($comment)."', 1, '".addslashes($b_full_name)."',
                '".addslashes($pwd)."', ' ', '".addslashes($index)." ".addslashes($addr)."', 1, 1)");
        $last_id = mysql_insert_id();        
        $s = sql("SELECT id, psw, email, name FROM client WHERE id=$last_id");
        $r = mysql_fetch_array($s);
        $tpl -> define(array(index => "register_ok.tpl"));
        $tpl -> assign( array( login => $r['email'], password => $r['psw'], mail => $r['email']));
        $tpl->parse(MAIN, "index");
        $tpl_main = $tpl -> get_assigned(MAIN);
        unset($_REQUEST['enter']);
			
            $mail_header = "MIME-Version: 1.0\r\n" . "Content-Type: text/plain; charset=\"utf-8\"\r\n" .
                        "From: ".$site_mail."\r\n";
            $message  = "Уважаемый " . $r['name'] . "!\n\n";
            $message .= "Вы зарегистрировались на сайте ".$site_name." \n";
            $message .= "Ваш логин: " . $r['email'] . "\n";
            $message .= "Ваш пароль: " .$r['psw']. "\n\n";
            $message .= "Спасибо за интерес проявленный к нашему интернет-магазину! \n";
            $message .= "С уважением, Администрация ".$site_name.". \n";
            mail($mail, $site_name.": Регистрация на сайте", $message, $mail_header);			

     endif;

  elseif ($_REQUEST['face'] == "jurr"):
     $ok = '';
     if ($name=="" || $phone=="" || $mail=="" || $index == "" || $addr=="" || $pwd=="" || $pwd_re=="" || $inn=="" || $rass=="" ||
            $bank=="" || $bik=="" || $kors=="" || $juradress=="" || $code=='' ):
        $msg = 'Внимание! Все поля формы должны быть заполнены!';
     else: 
        $s = sql("SELECT COUNT(*) FROM client WHERE group_id=1 AND email='".addslashes($mail)."'");
        $r = mysql_fetch_array($s);
        if ($r[0]>0):
            $msg = 'Внимание! Пользователь с таким e-mail уже существует!<br>Если Вы забыли реквизиты доступа, воспользуйтесь
             <a href="'.$site_url.'/restore_.html">формой восстановления пароля</a>';
        else:

		require $_SERVER['DOCUMENT_ROOT'].'/exform/captcha/securimage.php';
		$securimage = new Securimage();
		if($securimage->check($code) == false) $msg = 'Неверный код!'; else $ok = 'ok';

       endif;
     endif;
     if ($ok == 'ok'):
        
		sql("INSERT INTO client (name, phone, email, adress, note, group_id, full_name, psw, 
                                  form, inn, kpp, rass, kors, bank, bik, juradress) VALUES
               ('".addslashes($name)."', '".addslashes($phone)."', '".addslashes($mail)."', '".addslashes($index)." ".addslashes($addr)."',
                '".addslashes($comment)."', 1, '".addslashes($name)."', '".addslashes($pwd)."' , 
                '".addslashes($form)."', '".addslashes($inn)."', '".addslashes($kpp)."', '".addslashes($rass)."', '".addslashes($kors)."',
                '".addslashes($bank)."', '".addslashes($bik)."', '".addslashes($juradress)."')");
        $last_id = mysql_insert_id();
        $s = sql("SELECT id, psw, email, name, form FROM client WHERE id=$last_id");
        $r = mysql_fetch_array($s);
        $tpl -> define(array(index => "register_ok.tpl"));
        $tpl -> assign( array( login => $r['email'], password => $r['psw'], mail => $r['email']));
        $tpl->parse(MAIN, "index");
        $tpl_main = $tpl -> get_assigned(MAIN);
        unset($_REQUEST['enter']);
        
            $mail_header = "MIME-Version: 1.0\r\n" . "Content-Type: text/plain; charset=\"utf-8\"\r\n" .
                        "From: ".$site_mail."\r\n";
            $message  = "Уважаемый " .$r['form']. " " .$r['name']. "!\n\n";
            $message .= "Вы зарегистрировались на сайте ".$site_name." \n";
            $message .= "Ваш логин: " . $r['email'] . "\n";
            $message .= "Ваш пароль: " .$r['psw']. "\n\n";
            $message .= "Спасибо за интерес проявленный к нашему интернет-магазину! \n";
            $message .= "С уважением, Администрация Компании ".$site_name.". \n";
            mail($mail, $site_name.": Регистрация на сайте", $message, $mail_header);

     endif;
  endif;
  if ($msg != ''): $msg = '<div class="alert alert-error">'.$msg.'</div>'; endif;	
  if ($ok != 'ok'):
            $tpl -> assign( array( f_name => $f_name, m_name => $m_name, l_name => $l_name, name => $name, phone => $phone, mail => $mail, 
                                   addr => $addr, index => $index, comment => $comment, pwd  => $pwd,  pwd_re  => $pwd_re,  MSG =>  $msg, 
                                   kpp => $kpp, inn => $inn, rass=> $rass, bank => $bank, bik => $bik, kors => $kors, juradress => $juradress, code => $code, SHOP_NAME => $site_name ));
  endif;
else:
     $tpl -> assign( array( f_name => '', m_name => '', l_name => '', name => '', phone => '', mail => '', addr => '',
                            comment => '', pwd  => '',  pwd_re  => '',  MSG =>  '', kpp => '', index => '',
                            inn => '', rass=> '', bank => '', bik => '', kors => '', juradress => '', code => '', SHOP_NAME => $site_name ));
endif;

if ($ok != 'ok'):
  $tpl->parse(MAIN, "index");
  $tpl_main = $tpl -> get_assigned(MAIN);
endif;
?>