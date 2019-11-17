<?php 
header($_SERVER['SERVER_PROTOCOL']. ' 404 Not Found');
$title = 'Ошибка - 404. Старница не найдена';	
$meta_key = '';
$meta_descr = '';	
$tpl -> define(array(index => "404.tpl"));
$tpl->parse(MAIN, "index");
$tpl_main = $tpl -> get_assigned(MAIN);
?>