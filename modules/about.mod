<?php
  $title = 'О компании';
  $meta_key = 'запчасти для мотоциклов, квадроциклов, запчасти для гидроциклов, снегоходов, катеров';
  $meta_descr = 'Запчасти для мотоциклов и квадроциклов.';
  $page_title = 'О компании';

  $tpl -> define(array(index => "about.tpl"));
  


  $tpl->parse(MAIN, "index");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>