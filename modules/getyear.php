<?php
header("Content-type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
include_once('../init.inc');

if (isset($_REQUEST['brand'])): $brand = $_REQUEST['brand']; else: $brand = 0; endif;
echo '<option disabled selected>Год выпуска</option>'."\n";

	$s = sql("SELECT name, id FROM wn_model_year WHERE brand_id=$brand ORDER BY name DESC");
	while ($r = mysql_fetch_array($s)):
		echo '   <option value="'.$r['id'].'">'.$r['name'].'</option>'."\n";
	endwhile;

?>