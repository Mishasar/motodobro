<?php
	$title = 'Условия обработки персональных.';
	$meta_key = 'Условия обработки персональных';
	$meta_descr = 'Условия обработки персональных';

	$tpl -> define(array(index => "right.tpl"));
	
	$tpl->parse(MAIN, "index");
	$tpl_main = $tpl -> get_assigned(MAIN);

?>