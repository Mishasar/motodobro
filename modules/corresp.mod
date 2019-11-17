<?php
$tpl -> define( array(orders => "corresp.tpl"));
$tpl -> define_dynamic ( "order_row", "orders" );


$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
				<li class="active">Личный кабинет</li>';	


if ( isset($_REQUEST['add_msg']) ) {
	$msg = strip_tags($_REQUEST['question']);
	if ($msg != '') {
		$s = sql("SELECT IFNULL(id, 0) AS id FROM corresp WHERE answ=0 AND client_id=$user_id AND msg='$msg'");
		$r = mysql_fetch_array($s);
		if ($r['id'] == 0) {
			sql("INSERT INTO corresp (parent_id, m_date, client_id, status, msg, answ) VALUES (0, NOW(), $user_id, 0, '$msg', 0)");
			
		
			$s = sql("SELECT name, email FROM client WHERE id=$user_id");
			$r = mysql_fetch_array($s);
		
				$mail_header = "MIME-Version: 1.0\r\n" . "Content-Type: text/plain; charset=\"utf-8\"\r\n" .
							"From: ".$site_mail."\r\n";
				
				$message  = "На сайте задан вопрос в ЛК\n\n";
				$message .= "Время: ".date("d.m.Y H:i")." \n";
				$message .= "Имя: " . $r['name'] . "\n";
				$message .= "E-mail: " . $r['email'] . "\n";
				$message .= "Вопрос: " .$msg. "\n\n";			
				
				mail($site_mail, $site_name.": Вопрос в ЛК", $message, $mail_header);
		}
	}
}

$s = sql("SELECT th.id, th.parent_id, th.m_date, th.client_id, th.status, th.msg,
			IFNULL((SELECT MAX(m_date) FROM corresp p WHERE p.parent_id = th.id), th.m_date) as last_message
			FROM corresp th
			WHERE th.parent_id=0 AND th.client_id=$user_id ORDER BY last_message DESC");
         
if (mysql_num_rows($s)>0):
  while ($r = mysql_fetch_array($s)):
    if ($r['status'] == 0) {
		$status = '<span class="label label-warning">Вопрос не рассмотрен</span>';	
	} elseif ($r['status'] == 1) {
		$status = '<span class="label label-success">Новый ответ</span>';
	} else {
		$status = '<span class="label">Ответ прочитан</span>';
	}
	
	$msg = strip_tags($r['msg']);
	$msg = substr($msg, 0, 400);
	$msg = rtrim($msg, "!,.-");
	//$msg = substr($msg, 0, strrpos($msg, ' '));


 
        $tpl -> assign( array(m_date => strftime("%d.%m.%Y %H:%M", strtotime($r['m_date'])),
                              status     => $status,
							  msg_id => $r['id'],
							  msg	 => $msg .'...' ));
        $tpl -> parse(ORDER_ROW, ".order_row");

  endwhile;
  $no_msg = '';
else:
  $tpl -> clear_dynamic ( "order_row" );
  $no_msg = '<tr><td align="center" colspan="3"> <i>У вас еще не было задано ни одного вопроса менеджеру</i> </td></tr>';
endif;

    $tpl -> assign( array(h1 =>  'Переписка с менеджером',
						  no_msg => $no_msg,
                          navigate => $navigate,
                           ));


$tpl->parse(MAIN, "orders");
$tpl_main = $tpl -> get_assigned(MAIN);
?>