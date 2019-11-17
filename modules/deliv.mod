<?php

  $title = 'aaa';
  $meta_key = 'ads';
  $meta_descr = 'sss';

  $tpl -> define(array(index => "deliv.tpl"));
  


  $tpl->parse(MAIN, "index");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>