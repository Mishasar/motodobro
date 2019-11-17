<?php
header("Content-type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
include_once('../init.inc');

if (isset($_REQUEST['group'])): $group = $_REQUEST['group']; else: $group = 0; endif;
echo '<option disabled selected>Производитель</option>'."\n";

	$s = sql("SELECT name, id FROM w_brand WHERE group_id=$group AND c_type=3");
	while ($r = mysql_fetch_array($s)):
		echo '   <option value="'.$r['id'].'">'.$r['name'].'</option>'."\n";
	endwhile;

?>