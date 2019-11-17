<?php
if(!isset($_REQUEST['mf_theme'])) die('Restricted access');

$config->form_str_STOP = 'Стойте';
$config->form_header = 'Для Вас мы подготовили специальное предложение';
$config->form_str_TEXT = 'текст предложения';
$config->form_addmsg = '*Если Вы спешите - укажите только свой номер телефона';
$config->phone_title = 'Номер телефона';
$config->submit_title = 'Отправить скорее';
$config->submit_width = '95%';

$config->require_email = false;
$config->enable_captcha = false;
?>