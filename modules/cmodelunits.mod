<?php
  $tpl -> define(array('cModelYear' => "cmodelyear2.tpl"));

  $model_id = $state_value;
  $s = sql("SELECT g.prim as g_name, b.name as b_name, my.name as year, m.name as model_name,
            m.year_id, m.brand_id, m.group_id, g.id as gid
            FROM wn_model_year my, wn_model m, w_brand b, w_group g
            WHERE g.id=m.group_id AND b.id=m.brand_id AND my.id=m.year_id AND m.id=$model_id");
  $r = mysql_fetch_array($s);
  $model_name = stripslashes($r['model_name']);
  
  $page_title = $r[1].' '.$model_name;
  $page_key = $r['g_name'].'<br>'.$page_title;
  $h1 = $r[1].'<br>'.$model_name;
  $h3 = $r['g_name'];

  $title = $r[0].' '.$r[1].' '.$model_name.' ('.$r[2].')';
  $meta_key = $r[0].', '.$r[1].', '.$model_name.', '.$r[2];
  $meta_descr = $title;

  $brand_name = $r['b_name'];

	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/0_'.$r['gid'].'_'.encodestring($r['g_name']).'.html">'.$r['g_name'].'</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/1_'.$r['brand_id'].'_'.encodestring($r['g_name'].' '.$r['b_name']).'.html">'.$r['b_name'].'</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/2_'.$r['year_id'].'_'.encodestring($r['g_name'].' '.$r['b_name'].' '.$r['year']).'.html">'.$r['year'].'</a> <span class="divider">/</span></li>
	  <li class="active">'.$model_name.'</li>';				 

  $i = 0; $j = 1;
  $list_model = '<tr >';
  $s = sql("SELECT id, name_rus, name, img_small, img_path_sm FROM wn_units WHERE model_id=$model_id AND name <> '' ORDER BY id");
  
  $units = '';
  while ($r = mysql_fetch_array($s)):
        if ($r['name_rus'] == ''): $unit_name = $r['name']; else: $unit_name = $r['name_rus']; endif;
        $unit_name = str_replace("/", " / ", $unit_name);
	  if ($r['img_small'] != ''):
		$img = 'http://motodobro.ru'.'/pics/small/'.$r['img_path_sm'].'/'.$r['img_small'].'.gif';
	  else:
		$img = 'http://motodobro.ru'.'/pics/small/default.gif';
	  endif;
	  $i ++;
          
      $units .= '<div style="padding-bottom: 10px;"><a href="'.$site_url.'/5_'.$r['id'].'_'.encodestring($unit_name.' '.$model_name).'.html" ><img src="'.$img.'" class="img-polaroid"><div class="unit-image">'.$unit_name.'</div></a></div>';
  endwhile;
  
  /*
  while ($r = mysql_fetch_array($s)):
      if ($r['name_rus'] == ''): $unit_name = $r['name']; else: $unit_name = $r['name_rus']; endif;
      $unit_name = str_replace("/", " / ", $unit_name);
	  if ($r['img_small'] != ''):
		$img = $site_url.'/pics/small/'.$r['img_path_sm'].'/'.$r['img_small'].'.gif';
	  else:
		$img = $site_url.'/pics/small/default.gif';
	  endif;
	  $i ++;
	  
      $list_model .= '<td width="142" style="padding-bottom:4px; border: 1px dashed #d7d7d7;text-align: center;" valign="top">
						    <a href="'.$site_url.'/5_'.$r['id'].'_'.encodestring($unit_name.' '.$model_name).'.html" >
							<img src="'.$img.'" class="img-polaroid"><br>
                              '.$unit_name.'</a>
                      </td>';
      if ($i==6):
         $list_model .= '</tr><tr>'; $i = 0;
      endif;					  
		  
  endwhile;
  if ($i==1): $list_model .= '<td style="border-right:0px;" colspan="5">&nbsp;</td>'; endif;
  if ($i==2): $list_model .= '<td style="border-right:0px;" colspan="4">&nbsp;</td>'; endif;
  if ($i==3): $list_model .= '<td style="border-right:0px;" colspan="3">&nbsp;</td>'; endif;
  if ($i==4): $list_model .= '<td style="border-right:0px;" colspan="2">&nbsp;</td>'; endif;
  if ($i==5): $list_model .= '<td >&nbsp;</td>'; endif;
  $list_model .= '</tr>';
 */

 if ($brand_name == 'Harley Davidson'):
		$harlye_widget = '<table>
		                    <tr>
			               <td><h3>Присоединяйтесь к нашему сообществу Harley-Davidson в VK. Технические советы, события, объявления о продаже техники и б.у. запчастей.<h3></td>
			                <td>
			                <div id="vk_groups1"></div>
			                </td>
                            </tr>
		                  </table>
		                  <script type="text/javascript">
                                VK.Widgets.Group("vk_groups1", {mode: 0, width: "420", height: "200"}, 19051740);
                                </script>';
	else:
		$harlye_widget = '';
	endif;
  
  $tpl -> assign( array(  'h1' =>  $h1,
                          'h3' =>  $h3,
                          'navigate' => $navigate,
                          'harlye_widget' => $harlye_widget,
                          'units'=>$units,
                          'list_model' => $list_model ));  

  $tpl->parse('MAIN', "cModelYear");
  $tpl_main = $tpl -> get_assigned('MAIN');
?>