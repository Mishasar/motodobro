<?php
header("Content-type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
include_once('../init.inc');

	$s = sql("SELECT name, prim, id FROM w_group WHERE id NOT IN (9,10,11) ORDER BY ord");
	while ($r = mysql_fetch_array($s)):
		echo '   <option value="'.$r['id'].'">'.$r['name'].'</option>'."\n";
	endwhile;

?>