<?php
  $tpl -> define(array('cModel' => "cmodel.tpl"));

  $year_id = $state_value;
  $s = sql("SELECT g.prim as g_name, b.name as b_name, b.id, b.group_id, g.id as gid, my.name
       FROM w_brand b, w_group g, wn_model_year my WHERE g.id=b.group_id AND b.id=my.brand_id AND my.id=$year_id");
  $r = mysql_fetch_array($s);
  $title = $r[0].' '.$r[1].' '.$r['name'];
  $meta_key = $r[0].', '.$r[1].' '.$r['name'];
  $meta_descr = $title;
  $page_title = $r[1];
  $page_key = 'запчасти оптом и в розницу<br>'.$title;
  $year = stripslashes($r['name']);
  $h1 = $r[1].' '.$r['name'];
  $h3 = $r[0];
  $brand_id = $r['id'];
  $brand_name = $r['b_name'];

	$navigate = '<li><a href="'.$site_url.'/">Главная</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/0_'.$r['gid'].'_'.encodestring($r['g_name']).'.html">'.$r['g_name'].'</a> <span class="divider">/</span></li>
	  <li><a href="'.$site_url.'/1_'.$r['id'].'_'.encodestring($r['g_name'].' '.$r['b_name']).'.html">'.$r['b_name'].'</a> <span class="divider">/</span></li>
	  <li class="active">'.$r['name'].'</li>';

  $i = 0; $share_name = '';
  $list_model = '<tr>';

  $select_option = '';

  $s = sql("SELECT m.id, my.name as year_name, m.name as model_name, TRIM(m.share_name) as share_name FROM wn_model_year my, wn_model m
             WHERE m.year_id=my.id AND my.id=$year_id ORDER BY share_name, model_name");
  while ($r = mysql_fetch_array($s)):

        if ($share_name != $r['share_name']):
           if ($i==1): $list_model .= '<td >&nbsp;</td>'; endif;
           if ($i > 0): $list_model .= '</tr>'; endif;
           $list_model .= '<tr><td colspan="2" style="font-size:16px;" bgcolor="#f5f5f7">'.$r['share_name'].'</td></tr>';
           $select_option .= '<option>'.$r['share_name'].'</option>';
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
  if ($i==1): $list_model .= '<td >&nbsp;</td>'; endif;
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

  $tpl -> assign( array(  'h1' =>  $h1,
                          'h3' =>  $h3,
						  'brand_id' => $brand_id,
						  'brand_name' => $brand_name,
						  'harlye_widget' => $harlye_widget,
              'select_option' => $select_option, 
                          'navigate' => $navigate,
                          'list_model' => $list_model ));

  $tpl->parse('MAIN', "cModel");
  $tpl_main = $tpl -> get_assigned('MAIN');
?>
