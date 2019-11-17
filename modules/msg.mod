<?php
$tpl -> define( array(orders => "msg.tpl"));
$tpl -> define_dynamic ( "order_row", "orders" );

$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
			 <li><a href="'.$site_url.'/corresp.html">Список вопросов</a> <span class="divider">/</span></li>
			<li class="active">Просмотр вопроса</li>'; 	

$quest_id = (int)$state_value;

		$s = sql("SELECT status FROM corresp WHERE id=$quest_id");
		$r = mysql_fetch_array($s);
		if ($r['status'] == 1) {
			sql("UPDATE corresp SET status=2 WHERE id=$quest_id");
		}
		$s = sql("SELECT name, email FROM client WHERE id=$user_id");
		$r = mysql_fetch_array($s);
		$user_name = $r['name'];
		$user_email = $r['email'];

if ( isset($_REQUEST['add_msg']) ) {
	$msg = strip_tags($_REQUEST['question']);
	if ($msg != '') {
		$s = sql("SELECT IFNULL(id, 0) AS id FROM corresp WHERE answ=0 AND client_id=$user_id AND parent_id=$quest_id AND msg='$msg'");
		$r = mysql_fetch_array($s);
		if ($r['id'] == 0) {
			sql("INSERT INTO corresp (parent_id, m_date, client_id, status, msg, answ) VALUES ($quest_id, NOW(), $user_id, 0, '$msg', 0)");
			sql("UPDATE corresp SET status=0 WHERE id=$quest_id");
		

		
				$mail_header = "MIME-Version: 1.0\r\n" . "Content-Type: text/plain; charset=\"utf-8\"\r\n" .
							"From: ".$site_mail."\r\n";
				
				$message  = "На сайте задан вопрос в ЛК\n\n";
				$message .= "Время: ".date("d.m.Y H:i")." \n";
				$message .= "Имя: " . $user_name . "\n";
				$message .= "E-mail: " . $user_email . "\n";
				$message .= "Вопрос: " .$msg. "\n\n";			
				
				mail($site_mail, $site_name.": Вопрос в ЛК", $message, $mail_header);
		}
	}	
}

$s = sql("SELECT id, parent_id, m_date, client_id, status, msg, answ FROM corresp WHERE id=$quest_id
			UNION
			SELECT id, parent_id, m_date, client_id, status, msg, answ FROM corresp WHERE parent_id=$quest_id
			ORDER BY m_date");
         
if (mysql_num_rows($s)>0):
  while ($r = mysql_fetch_array($s)):
    if ($r['answ'] == 1) {
		$writer = '<span style="color:#46a546;">Менеджер</style>';	
	} else {
		$writer = '<span style="color:#049cdb;">'.$user_name.'</style>';
	} 
	
	$msg = strip_tags($r['msg']);


 
        $tpl -> assign( array(m_date => strftime("%d.%m.%Y %H:%M", strtotime($r['m_date'])),
                              writer     => $writer,
							  msg	 => $msg ));
        $tpl -> parse(ORDER_ROW, ".order_row");

  endwhile;
else:
  $tpl -> clear_dynamic ( "order_row" );
endif;

    $tpl -> assign( array(h1 =>  'Просмотр вопроса',
                          navigate => $navigate,
						  msg_id => $quest_id
                           ));


$tpl->parse(MAIN, "orders");
$tpl_main = $tpl -> get_assigned(MAIN);
?>