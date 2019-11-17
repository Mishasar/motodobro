<?php
include_once "code/append.php";
$title = 'Оплата заказа';
$h1 = $title;
$meta_key = '';
$meta_descr = '';
$page_title = $title;
$page_key = $title;


$order_id = 0;
$status = 0;
$result1 = $result2 = 123;

if (!empty($_REQUEST['USER_NAME']) && !empty($_REQUEST['USER_EMAIL']) && !empty($_REQUEST['USER_PHONE'])) {
    $name = mb_convert_case($_REQUEST['USER_NAME'], MB_CASE_TITLE, "UTF-8");
    $phone = $_REQUEST['USER_PHONE'];
    $mail = $_REQUEST['USER_EMAIL'];
    $s = sql("SELECT client.id, client.name FROM client WHERE email='" . addslashes($mail) . "'");
    $result = mysql_fetch_array($s);

    if ($result[0] > 0) {
        $user_id = $result['id'];
    } else {
        //Задаем длину пароля
        $length = 8;
        //Массив символов, из которых будет генерироваться пароль
        $arr = array('q', 'w', 'e', 'r', 't', 'y',
            'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h',
            'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm',
            'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P',
            'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L',
            'Z', 'X', 'C', 'V', 'B', 'N', 'M',
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
        //Инициализация переменой, которая будет содержать пароль
        $pwd = '';
        //Генерация пароля
        for ($i = 0; $i < $length; $i++) {
            $index = rand(0, count($arr) - 1);
            $pwd .= $arr[$index];
        }
        sql("INSERT INTO client (name, phone, email, adress, note, group_id, full_name, psw, form, juradress, c_import, r_int) VALUES
		   ('" . addslashes($name) . "', '" . addslashes($phone) . "', '" . addslashes($mail) . "', NULL, NULL, 1, '" . addslashes($name) . "', '" . addslashes($pwd) . "', ' ', NULL, 1, 1)");
        $last_id = mysql_insert_id();
        $s = sql("SELECT id, psw, email, name, phone FROM client WHERE id=$last_id");
        $r = mysql_fetch_array($s);
        $login = $r['email'];
        $pass = $r['psw'];
        $user_id = $r['id'];

        $link = '<a href="http://www.motodobro.ru/parts/orders.html?login=' . $login . '&pass=' . $pass . '">Для входа в личный кабинет, перейдите по этой ссылке</a>';

        $mail_header = "MIME-Version: 1.0\r\n" . "Content-Type: text/html; charset=\"utf-8\"\r\n" .
            "From: " . $site_mail . "\r\n";
        $message = "Уважаемый " . $r['name'] . "!<br><br>";
        $message .= "Вы зарегистрировались на сайте " . $site_name . " <br>";

        $message .= $link . " <br>";


        $message .= "Ваш логин: " . $r['email'] . "<br>";
        $message .= "Ваш пароль: " . $r['psw'] . "<br><br>";
        $message .= "Спасибо за интерес проявленный к нашему интернет-магазину! <br>";
        $message .= "С уважением, Администрация " . $site_name . ". <br>";
        mail($mail, $site_name . ": Регистрация на сайте", $message, $mail_header);

        $mail_header2 = "MIME-Version: 1.0\r\n" . "Content-Type: text/plain; charset=\"utf-8\"\r\n" .
            "From: " . $site_mail . "\r\n";

        $message = "На сайте зарегистрирован новый клиент!\n\n";
        $message .= "Время регистрации: " . date("d.m.Y H:i:s") . " \n";
        $message .= "Имя: " . $r['name'] . "\n";
        $message .= "Телефон: " . $r['phone'] . "\n";
        $message .= "E-mail: " . $r['email'] . "\n";
        $message .= "Пароль: " . $r['psw'] . "\n\n";
        mail('atmyspace@yahoo.com', $site_name . ": Регистрация клиента", $message, $mail_header2);
    }
}

if (isset($_REQUEST['d_adress']) || isset($_REQUEST['d_city']) || isset($_REQUEST['d_pasport'])) {
    $d_name = mysql_escape_string($_REQUEST['USER_NAME']);
    $d_zip = mysql_escape_string($_REQUEST['d_zip']);
    $d_adress = mysql_escape_string($_REQUEST['d_adress']);
    $d_pasport = mysql_escape_string($_REQUEST['d_pasport']);
    $d_city = mysql_escape_string($_REQUEST['d_city']);

    //id, name, zip_code, adress, edit_date
    $s = sql("SELECT id FROM client_deliv WHERE client_id=$user_id");
    $r = mysql_fetch_array($s);

    if ($r['id'] > 0) {
        sql("UPDATE client_deliv SET edit_date=NOW(), zip_code='$d_zip', name='$d_name', adress='$d_adress', pasport='$d_pasport', city='$d_city' WHERE id=" . $r['id']);
    } else {
        sql("INSERT INTO client_deliv (name, zip_code, adress, edit_date, client_id, pasport, city) VALUES ('$d_name', '$d_zip', '$d_adress', NOW(), $user_id, '$d_pasport', '$d_city')");
    }
}

if (isset($_REQUEST['pay'])) {
    $order_md5 = $_REQUEST['pay'];
    $s = sql("SELECT id, state1 FROM trans WHERE order_md5='$order_md5'");
    $r = mysql_fetch_array($s);
    $order_id = $r['id'];
    $status = $r['state1'];
}

if (isset($_REQUEST['order'])) {
    $s = sql("SELECT * FROM basket WHERE tmp_usr='$tmp_user_id'");

    if (mysql_num_rows($s) > 0) {
        $s = sql("SELECT value FROM currency_value WHERE curr_id=1 ORDER BY c_date DESC LIMIT 1");
        $r = mysql_fetch_array($s);
        $usd = $r['value'];
        $s = sql("SELECT value FROM currency_value WHERE curr_id=2 ORDER BY c_date DESC LIMIT 1");
        $r = mysql_fetch_array($s);
        $euro = $r['value'];
        $s = sql("SELECT MAX(num) FROM trans");
        $r = mysql_fetch_array($s);
        $num = $r[0] + 1;
        $delivery_type = mysql_escape_string($_REQUEST['delivery']);
        $face_id = 1;
        $face_rec_id = 1;

        sql("INSERT INTO trans (t_date, num, client, t_type, t_class, state1, state2, state3, curr, usd, euro,
			 nds_prc, nds_type, note, sum_order, sum_order_euro, sum_order_rub, face_id, face_rec_id, deliv) VALUES (NOW(), $num, $user_id, 1, 1, 0, 0, 0, 3, $usd, $euro,
			 18, 'выделить', '', 0, 0, 0, $face_id, $face_rec_id, $delivery_type )");
        $order_id = mysql_insert_id();
        $order_sum_usd = 0;
        $s = sql("SELECT b.*, d.brand, d.group_id, d.code, d.code_alt, d.descr, d.pr1, d.curr, b.descr as descr_rus
			 FROM basket b, detali d WHERE d.id=b.prod_id AND tmp_usr='$tmp_user_id'");

        while ($r = mysql_fetch_array($s)):
            $r['descr'] = str_replace("'", "", $r['descr']);
            $r['descr'] = str_replace("\\", "", $r['descr']);
            $r['descr_rus'] = str_replace("'", "", $r['descr_rus']);
            $r['descr_rus'] = str_replace("\\", "", $r['descr_rus']);

            sql("INSERT INTO trans_inv (brand, group_id, code, code_alt, descr, pr1, pr2, trans_id, prod_id, curr, price, qty, status, descr_rus)
			 VALUES ($r[brand], $r[group_id], '$r[code]', '$r[code_alt]', '$r[descr]', $r[pr1], $r[price_usd], $order_id, $r[prod_id], 1,
				$r[price_usd], $r[qty], 1, '$r[descr_rus]')");

            $order_sum_usd = $order_sum_usd + ($r['price_usd'] * $r['qty']);
        endwhile;

        $order_sum_rub = $order_sum_usd * $usd;

        if ($order_sum_rub < MIN_SERVICE_COST) {
            $order_sum_rub += SERVICE_PRICE;
            $order_sum_usd = $order_sum_rub / $usd;
        }

        $order_sum_euro = $order_sum_rub / $euro;
        $order_sum_usd = str_replace(",", ".", $order_sum_usd);
        $order_sum_rub = str_replace(",", ".", $order_sum_rub);
        $order_sum_euro = str_replace(",", ".", $order_sum_euro);
        $order_md5 = md5($order_id);

        sql("UPDATE trans SET sum_order=$order_sum_usd, sum_order_euro=$order_sum_euro, sum_order_rub=$order_sum_rub, order_md5='$order_md5' WHERE id=$order_id");
        sql("DELETE FROM basket WHERE tmp_usr='$tmp_user_id'");

        // отправляем на почту
        $message = '<html><head><title>Заказ из интернет магазина ' . $site_name . '</title></head><body><p>Заказ из интернет магазина ' . $site_name . '</p>';

        $s = sql("SELECT t.num, c.phone, c.email, c.adress, c.full_name FROM trans t, client c WHERE c.id=t.client AND t.id=$order_id");
        $r = mysql_fetch_array($s);
        $to = $r['email'];
        $message = '<div>Номер заказа: ' . $r['num'] . '</div>';
        $message .= '
				<table cellpadding="2" cellmargin="0">
				<tr><td align="right">Клиент:</td><td>' . $r['full_name'] . '</td></tr>
				<tr><td align="right">Телефон:</td><td>' . $r['phone'] . '</td></tr>
				<tr><td align="right">Email:</td><td>' . $r['email'] . '</td></tr>';

        $s = sql("SELECT * FROM client_deliv WHERE client_id=$user_id ORDER BY id DESC");
        if (mysql_num_rows($s) > 0) {
            $r = mysql_fetch_array($s);
            $message .= '<tr><td align="right">Получатель:</td><td>' . $r['name'] . '</td></tr>';
            $message .= '<tr><td align="right">Индекс:</td><td>' . $r['zip_code'] . '</td></tr>';
            $message .= '<tr><td align="right">Адрес доставки:</td><td>' . $r['adress'] . '</td></tr>';
        }
        $message .= '</table>';

        $i = 1;
        $message .= '
				<table cellpadding="2" cellmargin="0" border="1">
				<tr><th width="30"><small>н/н</small></th><th width="120"><small>код</small></th><th><small>описание</small></th>
					 <th width="80"><small>цена</small></th><th width="30"><small>кол</small></th><th width="80"><small>сумма</small></th></tr>';
        $s = sql("SELECT code, descr, descr_rus, price, curr, qty FROM trans_inv WHERE trans_id=$order_id");
        while ($r = mysql_fetch_array($s)):
            if ($r['descr_rus'] != ''): $descr = $r['descr_rus'];
            else: $descr = $r['descr']; endif;

            if ($r['curr'] == 1): $price = round($r['price'] * $usd, 2);
            elseif ($r['curr'] == 2): $price = round($r['price'] * $euro, 2);
            else: $price = $r['price'];
            endif;

            $sum = $price * $r['qty'];
            $message .= '<tr><td align="center">' . $i . '</td><td>' . $r['code'] . '</td><td>' . $descr . '</td><td>' . number_format($price, 2, '.', ' ') . '</td><td>' . $r['qty'] . '</td><td>' . number_format($sum, 2, '.', ' ') . '</td></tr>';
            $i++;
        endwhile;

        if ($order_sum_rub < MIN_SERVICE_COST) {
            $message .= '<tr><td align="center"></td><td></td><td>'.SERVICE_TEXT.'</td><td>' . number_format(SERVICE_PRICE, 2, '.', ' ') . '</td><td></td><td></td></tr>';
        }

        $message .= '</table>';
        $message .= '<br><br>Для оплаты перейдите на <a href="' . $site_url . '/orderpay.html?pay=' . $order_md5 . '">страницу оплаты заказа</a><br><br><br>';
        $message .= '</body></html>';

        $subject = "Заказ из интернет магазина $site_name";
        $headers = "Content-type: text/html; charset=utf-8 \r\n";
        $headers .= "From: $site_mail\r\n";

        mail($to, $subject, $message, $headers);
        //$subject = "Заказ $site_name";
        $subject = "Новый заказ";
        mail('atmyspace@yahoo.com', $subject, $message, $headers);
    }
}


$tpl->define(array('orderpay' => "orderpay.tpl"));
$tpl->define_dynamic("order_done", "orderpay");


$navigate = '<li><a href="' . $site_url . '/">Главная</a> <span class="divider">/</span></li><li class="active">Оплата заказа</li>';

if ($order_id == 0 or $status > 0) {
    $content = '<div class="alert alert-error"><h4 class="alert-heading">Ошибка!</h4> Заказа не существует или он уже оплачен!</div>';
    if ($user_id > 0) {
        $back = '<a href="{_SITE_}/orders.html" role="button" class="btn btn-large btn-inverse" ><i class="icon-arrow-left icon-white"></i> Назад </a>';
    } else {
        $back = '<a href="{_SITE_}/" role="button" class="btn btn-large btn-inverse" ><i class="icon-arrow-left icon-white"></i> Назад </a>';
    }
    $tpl->clear_dynamic("order_done");
} else {
    switch ($_REQUEST['delivery']) {
        case 2:
            $deliveryName = 'Почта России';
            break;
        case 3:
            $deliveryName = 'ТК Деловые Линии';
            break;
        case 4:
            $deliveryName = 'EMS.';
            break;
        default:
            $deliveryName = 'СДЕК';
            break;
    }

    $passportResult = !empty($_REQUEST['d_pasport']) ? $_REQUEST['d_pasport'] : "нет";
    $zipResult = !empty($_REQUEST['d_zip']) ? $_REQUEST['d_zip'] : "нет";
    $s = sql("SELECT num, sum_order_rub, order_md5 FROM trans WHERE id=$order_id");
    $r = mysql_fetch_array($s);
    $md5_id = $r['order_md5'];
    $content = 'Заказ <b>№ ' . $r['num'] . ' </b> успешно оформлен.<br>';
    $content .= 'Итого к оплате: <b>' . number_format($r['sum_order_rub'], 2, '.', ' ') . ' руб.</b>';

    addRowToSpreadsheet([
        "",
        $deliveryName,
        date('d.m.Y H:i:s'),
        "",
        "",
        $r['num'],
        "",
        "",
        $_REQUEST['d_city'] . ', ' . $_REQUEST['d_adress'],
        "",
        $_REQUEST['USER_NAME'],
        $_REQUEST['USER_PHONE'],
        "",
        "",
        $passportResult,
        "",
        "",
        "",
        $zipResult
    ]);

    $prim = '';
    $s2 = sql("SELECT * FROM site_template WHERE id=4");
    $r2 = mysql_fetch_array($s2);

    if ($r2['page_content'] != '') {
        $prim = '<br><br><div class="alert alert-info"><a class="close" data-dismiss="alert">×</a><strong>' . $r2['page_header'] . '</strong> ' . $r2['page_content'] . '</div>';
    }

    $s2 = sql("SELECT * FROM site_template WHERE id=5");
    $r2 = mysql_fetch_array($s2);

    if ($r2['page_header'] != '') {
        $card_num = $r2['page_header'];
    }

    if ($r2['page_content'] != '') {
        $card_info = $r2['page_content'];
    }

    $tpl->assign(array('prim' => $prim, 'card_num' => $card_num, 'card_info' => $card_info, 'id' => $md5_id));
    $back = '';
    $tpl->parse('ORDER_DONE', ".order_done");
}

$tpl->assign(array('h1' => $h1,
    'navigate' => $navigate,
    'content' => $content,
    'back' => $back
));

$tpl->parse('MAIN', "orderpay");
$tpl_main = $tpl->get_assigned('MAIN');
?>