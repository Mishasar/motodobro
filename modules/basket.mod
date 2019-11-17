<?php

if (isset($_REQUEST['product_id']) and $_REQUEST['qty'] > 0) {
    $s = sql("UPDATE basket SET qty=$_REQUEST[qty] WHERE tmp_usr='$tmp_user_id' AND prod_id=$_REQUEST[product_id]");
}

if (isset($_REQUEST['delete']) and $_REQUEST['delete'] > 0) {
    sql("DELETE FROM basket WHERE tmp_usr='$tmp_user_id' AND prod_id=" . $_REQUEST['delete']);
}

function russian_date($d)
{
    $date = explode(".", $d);
    switch ($date[1]) {
        case 1:
            $m = 'янв';
            break;
        case 2:
            $m = 'фев';
            break;
        case 3:
            $m = 'мар';
            break;
        case 4:
            $m = 'апр';
            break;
        case 5:
            $m = 'мая';
            break;
        case 6:
            $m = 'июн';
            break;
        case 7:
            $m = 'июл';
            break;
        case 8:
            $m = 'авг';
            break;
        case 9:
            $m = 'сен';
            break;
        case 10:
            $m = 'окт';
            break;
        case 11:
            $m = 'ноя';
            break;
        case 12:
            $m = 'дек';
            break;
    }
    return $date[0] . ' ' . $m;
}


if (isset($_REQUEST['adress'])) {
    $d_name = mysql_escape_string($_REQUEST['d_name']);
    $d_zip = mysql_escape_string($_REQUEST['d_zip']);
    $d_adress = mysql_escape_string($_REQUEST['d_adress']);
    $d_pasport = mysql_escape_string($_REQUEST['d_pasport']);
    $d_city = mysql_escape_string($_REQUEST['d_city']);
    $d_delivery = mysql_escape_string($_REQUEST['delivery']);

    //id, name, zip_code, adress, edit_date
    $s = sql("SELECT id FROM client_deliv WHERE client_id=$user_id /*AND name='$d_name' AND adress='$d_adress'*/");
    $r = mysql_fetch_array($s);
    if ($r['id'] > 0) {
        sql("UPDATE client_deliv SET edit_date=NOW(), zip_code='$d_zip', name='$d_name', delivery='$d_delivery', adress='$d_adress', pasport='$d_pasport', city='$d_city' WHERE id=" . $r['id']);
    } else {
        sql("INSERT INTO client_deliv (name, zip_code, adress, edit_date, client_id, pasport, city, delivery) VALUES ('$d_name', '$d_zip', '$d_adress', NOW(), $user_id, '$d_pasport', '$d_city', '$d_delivery')");
    }
}


$title = 'Ваш заказ';
$h1 = $title;
$meta_key = '';
$meta_descr = '';
$page_title = $title;
$page_key = $title;

$tpl->define(array('preorder' => "basket.tpl"));

//Если пользователь авторизован - не спрашиваем email, name, phone
if ($user_id == 0) {
    $tpl->define_dynamic("bool_reg", "preorder");
    $tpl->parse('bool_reg1', ".bool_reg");
}

$tpl->define_dynamic("order_row", "preorder");


$parts_array = [];

$s = sql("SELECT b.*, d.code, d.descr as en_descr
         FROM basket b 
         LEFT JOIN detali d ON d.id=b.prod_id WHERE tmp_usr='$tmp_user_id'");

$total_sum = 0;

while ($r = mysql_fetch_array($s)):
    $parts_array[] = $r;
    $sum = $r['price'] * $r['qty'];
    $total_sum = $total_sum + $sum;
endwhile;

if (empty($parts_array)) {
    header("Location: /");
    exit();
}

foreach ($parts_array as $part) {
    $code = $part['code'];

    $s3 = sql("SELECT SUM(qty) AS qty FROM ware_inv WHERE trans_id=0 AND code='" . $code . "'");
    $r3 = mysql_fetch_array($s3);

    if ($r3['qty'] > 0) {
        $delivery_time = 'в наличии';
    } else {
        $delivery_time = 'приблизительно ' . russian_date(date('d.m.Y', strtotime('+14 day'))) . '...' . russian_date(date('d.m.Y', strtotime('+21 day')));
    }

    $quantityCell = '<a class="btn add-on" ' . (($part['qty'] > 1) ? "" : "disabled") . ' href="/basket.html?product_id=' . $part['prod_id'] . '&qty=' . ($part['qty'] - 1) . '">-</a>';
    $quantityCell = $quantityCell . '<input class="span2 js-basket-qty basket-quantity" size="16" type="number" data-id="' . $part['prod_id'] . '" value="' . $part['qty'] . '" style="width:32px;">';
    $quantityCell = $quantityCell . '<a class="btn add-on" href="/basket.html?product_id=' . $part['prod_id'] . '&qty=' . ($part['qty'] + 1) . '">+</a>';

    $del_link = "<a href=\"/basket.html?delete=".$part['prod_id']."\" data-toggle=\"tooltip\"
                       title=\"удалить товар из корзины\">
                        <img src=\"/img/cross.png\" height=\"24\" width=\"24\" hspace=\"0\" vspace=\"0\">
                    </a>";

    $tpl->assign(array('id' => $part['prod_id'],
        'product_id' => $part['prod_id'],
        'code' => addslashes($part['code']),
        'descr' => $part['descr'],
        'qty' => $quantityCell,
        'sum' => number_format($part['price'] * $part['qty'], 2, '.', ' '),
        'delivery' => $delivery_time,
        'site_url' => $site_url,
        'del_link' => $del_link
    ));
    $tpl->parse('ORDER_ROW', ".order_row");
}

if ($total_sum < MIN_SERVICE_COST) {
    $tpl->assign(array('id' => $part['prod_id'],
        'product_id' => "",
        'code' => "",
        'descr' => SERVICE_TEXT,
        'qty' => "",
        'sum' => number_format(SERVICE_PRICE, 2, '.', ' '),
        'delivery' => "",
        'site_url' => "",
        'del_link' => ""
    ));

    $tpl->parse('ORDER_ROW', ".order_row");
    $total_sum += SERVICE_PRICE;
}

$d_name = $d_zip = $d_adress = $d_pasport = $d_city = $d_state = "";

if ($user_id != 0) {
//id, name, zip_code, adress, edit_date
    $s2 = sql("SELECT * FROM client_deliv WHERE client_id=$user_id ORDER BY id DESC");
    $r2 = mysql_fetch_array($s2);
    $d_name = $r2['name'];
    $d_zip = $r2['zip_code'];
    $d_adress = $r2['adress'];
    $d_pasport = $r2['pasport'];
}

$navigate = '<li><a href="' . $site_url . '/">Главная</a> <span class="divider">/</span></li><li class="active">Ваш заказ</li>';

$tpl->assign(array('navigate' => $navigate,
    'total_sum' => number_format($total_sum, 2, '.', ' '),
    'd_name' => $d_name,
    'd_zip' => $d_zip,
    'd_adress' => $d_adress,
    'd_pasport' => $d_pasport,
    'd_state' => $d_state,
    'd_city' => $d_city
));

$tpl->parse('MAIN', "preorder");
$tpl_main = $tpl->get_assigned('MAIN');

?>