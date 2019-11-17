<?php
/**
 * mForm v2.0
 * Lopulyak Oleg < ol_lo@ukr.net >
 * Created 10.02.2013 ( updates 15.09.2014 )
 */

if (!isset($_REQUEST['mf_path']) && !isset($_REQUEST['mf_captcha_code'])) die('Restricted access');

//Проверка значения "имя"
if(isset($_REQUEST['mf_name'])){
 
 $field_value['name'] = $_REQUEST['mf_name'];
 
 if($_REQUEST['mf_name'] == '' || $_REQUEST['mf_name'] == $config->empty_value || $_REQUEST['mf_name'] == $config->error_name_value){
  $total_errors ++;
  $field_value['name'] = $config->empty_value;
  $field_value['name_err'] = $config->empty_value;
  $field_class['name'] = 'mf_error';
 }
 elseif(!preg_match("/^[a-zA-ZабвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ ]+$/",$_REQUEST['mf_name'])){
  $total_errors ++;
  $field_value['name_err'] = $config->error_name_value;
  $field_class['name'] = 'mf_error';
 }
}

//Проверка значения "телефон"
if(isset($_REQUEST['mf_phone'])){
 
 $field_value['phone'] = $_REQUEST['mf_phone'];
 
 if($_REQUEST['mf_phone'] == '' || $_REQUEST['mf_phone'] == $config->empty_value || $_REQUEST['mf_phone'] == $config->error_phone_value){
  $total_errors ++;
  $field_value['phone'] = $config->empty_value;
  $field_value['phone_err'] = $config->empty_value;
  $field_class['phone'] = 'mf_error';
 }
 elseif(!preg_match('/^((8|0|((\+|00)\d{1,2}))[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$/',$_REQUEST['mf_phone'])){
  $total_errors ++;
  $field_value['phone_err'] = $config->error_phone_value;
  $field_class['phone'] = 'mf_error';
 }
}

//Проверка значения "время звонка"
if(isset($_REQUEST['mf_phone_time']) && isset($config->phone_time_value)){ 
 if(trim($_REQUEST['mf_phone_time']) == '') $_REQUEST['mf_phone_time'] = $config->phone_time_value; 
 $field_value['phone_time'] = $_REQUEST['mf_phone_time'];
}

//Проверка значения "Название товара"
if(isset($_REQUEST['mf_product_name'])) $field_value['product_name'] = $_REQUEST['mf_product_name'];


//Проверка значения "email"
if (isset($_REQUEST['mf_email'])){
 
 $field_value['email'] = $_REQUEST['mf_email'];
 if($config->require_email){ 
  if($_REQUEST['mf_email'] == '' || $_REQUEST['mf_email'] == $config->empty_value || $_REQUEST['mf_email'] == $config->error_email_value){
   $total_errors ++;
   $field_value['email'] = $config->empty_value;
   $field_value['email_err'] = $config->empty_value;
   $field_class['email'] = 'mf_error';
  }
  elseif (!preg_match("/^[0-9a-zA-Z]+([0-9a-zA-Z]*[-._+])*[0-9a-zA-Z]+@[0-9a-zA-Z]+([-.][0-9a-zA-Z]+)*([0-9a-zA-Z]*[.])[a-zA-Z]{2,6}$/",$_REQUEST['mf_email'])){
   $total_errors ++;
   $field_value['email_err'] = $config->error_email_value;
   $field_class['email'] = 'mf_error';
  }
 }
}

//Проверка значения "captcha"
if($config->enable_captcha){

 if($_REQUEST['mf_captcha_code'] == '' || $_REQUEST['mf_captcha_code'] == $config->empty_value || $_REQUEST['mf_captcha_code'] == $config->error_captcha_value){
  $total_errors ++;
  $field_value['captcha'] = $config->empty_value;
  $field_value['captcha_err'] = $config->empty_value;
  $field_class['captcha'] = 'mf_error';
 }
 elseif($securimage->check($_REQUEST['mf_captcha_code']) == false) {
  $total_errors ++;
  $field_value['captcha'] = $config->error_captcha_value;
  $field_value['captcha_err'] = $config->error_captcha_value;
  $field_class['captcha'] = 'mf_error';
 }
}

if(isset($_REQUEST['mf_message'])) $field_value['message'] = $_REQUEST['mf_message'];
?>