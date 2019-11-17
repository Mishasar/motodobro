<?php

$tpl -> define_dynamic ( "row_menu", "acc_catalog" );
$s = sql("SELECT ifnull(g.name_rus, g.name) as name, g.id, c.name AS c_name FROM w_un_group g, w_un_catalog c WHERE c.id=g.catalog_id AND g.catalog_id=$catalog_id ORDER BY g.name");
while ($r = mysql_fetch_array($s)){
    $gr_active == $r['id'] ? $cl = 'active' : $cl = '';
	$url = $site_url.'/7_'.$r['id'].'_'.encodestring($r['name'].' '.$r['c_name']).'.html';
	$tpl -> assign( array(CL     =>  $cl,
                          NAME   =>  '<a href="'.$url.'">'.$r['name'].'</a>'));
    $tpl -> parse(ROWS_CAT, ".row_menu");    
}
?>