<?php
header("Content-type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
include_once('../init.inc');

if (isset($_REQUEST['year'])): $year = $_REQUEST['year']; else: $year = 0; endif;
echo '<option disabled selected>Модель</option>'."\n";

	$s = sql("SELECT name, id FROM wn_model WHERE year_id=$year");
	while ($r = mysql_fetch_array($s)):
		echo '   <option value="'.$r['id'].'">'.$r['name'].'</option>'."\n";
	endwhile;

?>