<?php

$year_id = $_REQUEST['year_id'];
$name = $_REQUEST['name'];
if($name != ''){

$s = sql("SELECT m.id, my.name as year_name, m.name as model_name, TRIM(m.share_name) as share_name FROM wn_model_year my, wn_model m
           WHERE m.year_id=my.id AND my.id=$year_id AND m.share_name=$name ORDER BY share_name, model_name");
         }
         else {
           $s = sql("SELECT m.id, my.name as year_name, m.name as model_name, TRIM(m.share_name) as share_name FROM wn_model_year my, wn_model m
                      WHERE m.year_id=my.id AND my.id=$year_id ORDER BY share_name, model_name");
         }

           $list_model = '<tr>';
while ($r = mysql_fetch_array($s)):

      if ($share_name != $r['share_name']):
         if ($i==1): $list_model .= '<td >&nbsp;</td>'; endif;
         if ($i > 0): $list_model .= '</tr>'; endif;
         $list_model .= '<tr><td colspan="2" style="font-size:16px;" bgcolor="#f5f5f7">'.$r['share_name'].'</td></tr>';
         $select_option .= '<option value="'.$r['share_name'].'">'.$r['share_name'].'</option>';
         $list_model .= '<tr>';
         $share_name = $r['share_name'];
         $i = 0;
      endif;
      $i ++;
      $list_model .= '<td width="50%" ';
      if ($i==1): $list_model .= 'align="right" style="padding:4px; padding-right:10px;"';
      else: $list_model .= 'align="left" style="padding:4px; padding-left:10px;"';
      endif;
      $list_model .= '><a href="'.$site_url.'/4_'.$r['id'].'_'.encodestring($r['model_name']).'.html" style="font-size:14px;">'.$r['model_name'].'</a></td>';

    if ($i==2):
       $list_model .= '</tr><tr>'; $i = 0;
    endif;
endwhile;
?>
