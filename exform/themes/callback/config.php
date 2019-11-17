<?php
if(!isset($_REQUEST['mf_theme'])) die('Restricted access');

$config->form_addmsg = '*Если Вы спешите - укажите только свой номер телефона';
$config->form_header = 'Закажите обратный звонок';
$config->phone_title = 'Номер телефона';
$config->phone_time_title = 'Удобное время для звонка';
$config->phone_time_value = 'в любое время';
//$config->enable_captcha = false;

$field_value = array_merge($field_value, array(
	'phone_time'=>'',
)); 

$field_class = $field_value;
?>