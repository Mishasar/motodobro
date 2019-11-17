<?php
  $tpl -> define(array(cBrand => "cbrand.tpl"));
  $tpl -> define_dynamic ( "harley_bloc", "cBrand" );
  
  $brand_id = $state_value;
  $s = sql("SELECT g.prim as g_name, b.name as b_name, b.id, b.group_id, wimg, g.id as gid, b.brand_desc as brand_desc FROM w_brand b, w_group g WHERE g.id=b.group_id AND b.id=$brand_id");
  $r = mysql_fetch_array($s);
  $title = $r[0].' '.$r[1];
  $meta_key = $r[0].', '.$r[1];
  $meta_descr = $title;
  $page_title = $r[1];
  $page_key = 'запчасти оптом и в розницу<br>'.$title;
  $wimg = $r['wimg'];
  $h1 = $r[1];
  $h3 = $r[0];
  $brand_name = $r['b_name'];
  $brand_desc = $r['brand_desc'];
  
	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/0_'.$r['group_id'].'_'.encodestring($r['g_name']).'.html">'.$r['g_name'].'</a> <span class="divider">/</span></li>
	  <li class="active">'.$h1.'</li>';  

  $i = 0; $j = 1;
  $list_model = '<tr >';
  $s = sql("SELECT y.id, y.name FROM wn_model_year y WHERE y.brand_id=$brand_id AND (SELECT COUNT(*) FROM wn_model WHERE year_id=y.id) > 0 ORDER BY y.name DESC");
  while ($r = mysql_fetch_array($s)):
      $i ++;

      $large = strpos ($r[0], 'новее');
      if($large!==false):
         $csp = ' width="40%" colspan="2" '; $i ++;
      else:
         $csp = ' width="20%" '; endif;

      $list_model .= '<td '.$csp.'><a href="'.$site_url.'/2_'.$r[0].'_'.encodestring($title.' '.$r[1]).'.html" style="font-size: 20px;">'.$r[1].'</a></td>';
      if ($i==5):
         $list_model .= '</tr><tr >'; $i = 0;
      endif;
  endwhile;
  if ($i==1): $list_model .= '<td colspan="4">&nbsp;</td>'; endif;
  if ($i==2): $list_model .= '<td colspan="3">&nbsp;</td>'; endif;
  if ($i==3): $list_model .= '<td colspan="2">&nbsp;</td>'; endif;
  if ($i==4): $list_model .= '<td >&nbsp;</td>'; endif;
  $list_model .= '</tr>';


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

  $tpl -> assign( array(  h1 =>  $h1,
                          h3 =>  $h3,
						  brand_id => $brand_id,
						  brand_name => $brand_name,
						  harlye_widget => $harlye_widget,
                          wimg => $wimg,
                          navigate => $navigate,
                          list_model => $list_model,
                          brand_desc => $brand_desc ));

  $tpl->parse(MAIN, "cBrand");
  $tpl_main = $tpl -> get_assigned(MAIN);
?>
