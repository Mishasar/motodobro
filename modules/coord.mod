<?php
  $title = 'Запчасти для мотоциклов и квадроциклов. Запчасти для гидроциклов, снегоходов катеров.';
  $meta_key = 'запчасти для мотоциклов, квадроциклов, запчасти для гидроциклов, снегоходов, катеров';
  $meta_descr = 'Запчасти для мотоциклов и квадроциклов.';
  $page_title = 'запчасти оптом и в розницу';
  $page_key = 'запчасти для мотоциклов и квадроциклов<br>ATV (АТВ), гидроциклов, снегоходов<br>катеров, подвесных и стационарных моторов';

  $tpl -> define(array(index => "coord.tpl"));
  


  $tpl->parse(MAIN, "index");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>