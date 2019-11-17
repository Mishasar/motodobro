<?php
  $title = 'Способы оплаты товара';
  $meta_key = 'запчасти для мотоциклов, квадроциклов, запчасти для гидроциклов, снегоходов, катеров';
  $meta_descr = 'Запчасти для мотоциклов и квадроциклов.';

  $tpl -> define(array(index => "pay.tpl"));
  


  $tpl->parse(MAIN, "index");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>