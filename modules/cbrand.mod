<?php
  $brand_id = $state_value;
  $s = sql("SELECT COUNT(*) FROM wn_model_year WHERE brand_id=$brand_id");
  $r = mysql_fetch_array($s);
  if ($r[0] == 1):
    $s = sql("SELECT id FROM wn_model_year WHERE brand_id=$brand_id");
    $r = mysql_fetch_array($s);
    $state_value = $r[0];
    $_lnk[2] = $brand_id;
    include ('modules/cmodel.mod');
  else:
    $s = sql("SELECT c_type FROM w_brand WHERE id=$brand_id");
    $r = mysql_fetch_array($s);
    include ('modules/cbrand_t'.$r[0].'.mod');
  endif;
?>