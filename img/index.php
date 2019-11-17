<?php
include_once ('init.inc');


# Если пользователь набрать домен без www
/*if (!preg_match( '|^www\..*|', $_SERVER [ 'HTTP_HOST' ])) {
	# переадресовываем на домен с www
	header ( 'HTTP/1.0 301 Moved Permanently' );
	$url = trim ($_SERVER [ 'REQUEST_URI' ], '/');
	if(trim($_SERVER [ 'REQUEST_URI' ], '/') != '') $url .= '/';
	header('Location: '.$site_url. '/' .$url);
	die();
}
*/




session_start();
include 'modules/_meta.php';
include('includes/cls_fast_template.php');
include('includes/gorod.php');
//$tmp_user_id = session_id();
$tmp_user_id = user_track();

$tpl = new FastTemplate("templates/");
$tpl -> define( array( main          => "m_main.tpl",
                       header        => "m_header.tpl",
                       footer        => "m_footer.tpl"));
$tpl -> define_dynamic ( "enter_reg", "header" );
$tpl -> define_dynamic ( "enter_no_reg", "header" );					   

 /* $title = 'МотоДобро - Мотозапчасти на заказ из Японии и США!';
  $meta_key = 'honda, kawasaki, suzuki, yamaha, байк, байкеры, доставка, заказ запчастей, заказ мотозапчастей, мото, мото запчасти, мотозапчасти, мотоцикл';
  $meta_descr = 'Мотозапчасти на заказ из Японии и США!';*/

$url_array = array();
$url_array = explode('/', $_SERVER['REQUEST_URI']);
$pos = strpos($url_array[count($url_array) - 1], '.');
$ttt = substr($url_array[count($url_array) - 1], 0 , $pos);

$_lnk = array();
$_lnk = explode('_',$ttt);
if (isset($_REQUEST['state'])):
   $state = $_REQUEST['state'];
   $state_value = $_REQUEST['state_value'];
else:
   if ($url_array[1] == "supplier"):
		$state = "supplier";
		$supplier = urldecode($url_array[2]);
		$pos = strpos($url_array[3], '.html');
		$code = urldecode ( substr($url_array[3], 0 , $pos));
   else:
		$state = $_lnk[0]; $state_value = $_lnk[1];
   endif;
endif;

$error_autch = false;

//Авторизация

if ($state == 'exit'): $_SESSION['user_id'] = 0; $user_id = 0; endif;
//$user_id = 0;
if (isset($_SESSION['user_id']) && $_SESSION['user_id'] > 0): $user_id = $_SESSION['user_id']; endif;
if (isset($_REQUEST['login'])):
   $s_login = $_REQUEST['login'];
   $s_pass = $_REQUEST['pass'];
   include('modules/autch.mod');
   if(auth_Check($s_login, $s_pass)): $user_id = $_SESSION['user_id']; 
   else: $error_autch = true;  endif;
endif;
if ($user_id > 0): 
	$tpl -> parse(ENTER_REG, ".enter_reg");
	$tpl -> clear_dynamic ( "enter_no_reg" );
else:
	$tpl -> parse(ENTER_NO_REG, ".enter_no_reg");
	$tpl -> clear_dynamic ( "enter_reg" );
endif;
$auth_form_action = $site_url.'/parts/orders.html';

switch ($state) {
    case "cModelUnits":
        include ('modules/cmodelunits.mod'); break;
    case "cModelParts":
        include ('modules/cmodelparts.mod'); break;
    case "cFilterResult":
        include ('modules/cfilterresult.mod'); break;	
    case "srh":
        include ('modules/srh.mod'); break;
    case "all_models":
        include ('modules/all_models.mod'); break;
	case "0":	
		include ('modules/cgroup.mod'); break;	
	case "1":	
        include ('modules/cbrand.mod'); break;
	case "2":	
        include ('modules/cmodel.mod'); break;
	case "3":	
        include ('modules/cpart.mod'); break;
    case "4":
        include ('modules/cmodelunits.mod'); break;		
    case "5":
        include ('modules/cmodelparts.mod'); break;
		
    case "6":
        include ('modules/acc_index.mod'); break;	
    case "7":
        include ('modules/acc_group.mod'); break;
    case "8":
        include ('modules/acc_category.mod'); break;
    case "9":
        include ('modules/acc_prod.mod'); break;	
		
    case "supplier":
        include ('modules/prod.mod'); break;		
		
    case "reg2":
        include ('modules/reg2.mod'); break;
    case "preorder":
        include ('modules/preorder.mod'); break;
    case "orderpay":
        include ('modules/orderpay.mod'); break;		
		
    case "rightreg":
        include ('modules/rightreg.mod'); break;		
    case "rightdeliv":
        include ('modules/rightdeliv.mod'); break;			
		
    case "register":
        include ('modules/register.mod'); break;
    case "restore":
        include ('modules/restore.mod'); break;		
    case "basket":
		if ($_REQUEST['face']!=''){
		 include ('modules/register.mod'); break;
		}else{
        include ('modules/basket.mod');}
		 break;
    case "orders":
        if ($user_id > 0): include ('modules/orders.mod'); else: $error_autch = true; endif;
        break;
    case "corresp":
        if ($user_id > 0): include ('modules/corresp.mod'); else: $error_autch = true; endif;
        break;	
    case "msg":
        if ($user_id > 0): include ('modules/msg.mod'); else: $error_autch = true; endif;
        break;		
    case "order":
        if ($user_id > 0): include ('modules/order.mod'); else: $error_autch = true; endif;
        break;
    case "printkvit":
        if ($user_id > 0): include ('modules/print_kvit.mod'); exit; else: $error_autch = true; endif;

    case "about":
        include ('modules/about.mod'); break;
    case "pay":
        include ('modules/pay.mod'); break;
    case "coord":
        include ('modules/coord.mod'); break;
    case "deliv":
        include ('modules/deliv.mod'); break;		
    default: 		
		 include ('modules/index.mod'); break;
		 //include('modules/' . ($_SERVER['REQUEST_URI'] == $site_url ? 'index.mod' : '404.mod')); break;
}

// ошибка авторизации
if ($error_autch):
    $tpl -> define(array(autch => "autch.tpl"));
    $tpl->parse(MAIN, "autch");
    $tpl_main = $tpl -> get_assigned(MAIN);
endif;

// меню OEM запчасти
	$oem_menu = '<ul class="dropdown-menu pull-right" role="menu">';
	$s = sql("SELECT id, name, prim FROM w_group ORDER BY ord");
	while ($r = mysql_fetch_array($s)):
		$oem_menu .= '<li class="dropdown-submenu">
						<a tabindex="-1" href="#">'.$r['name'].'</a>
						<ul class="dropdown-menu pull-left">';
		$s2 = sql("SELECT id, name FROM w_brand WHERE group_id=".$r['id']." ORDER BY name");
		while ($r2 = mysql_fetch_array($s2)):						
			$url = $site_url.'/1_'.$r2['id'].'_'.encodestring($r['prim'].' '.$r2['name']).'.html';
			$oem_menu .= '<li><a tabindex="-1" href="'.$url.'" style="text-align:left;">'.$r2['name'].'</a></li>';
		endwhile;	
		$oem_menu .= '</ul>
					</li>';				
	endwhile;
	$oem_menu .= '</ul>';
// меню Аксессуары запчасти
	$acc_menu = '<ul class="dropdown-menu pull-right" role="menu">';
	$s = sql("SELECT id, name  FROM w_un_brand WHERE tpl=3 ORDER BY name");
	while ($r = mysql_fetch_array($s)):
		$acc_menu .= '<li class="dropdown-submenu">
						<a tabindex="-1" href="#">'.$r['name'].'</a>
						<ul class="dropdown-menu pull-left">';
		$s2 = sql("SELECT id, name FROM w_un_catalog WHERE oem_group_id=".$r['id']." ORDER BY ord");
		while ($r2 = mysql_fetch_array($s2)):						
			$url = $site_url.'/6_'.$r2['id'].'_'.encodestring($r2['name']).'.html';
			$acc_menu .= '<li><a tabindex="-1" href="'.$url.'" style="text-align:left;">'.$r2['name'].'</a></li>';
		endwhile;	
		$acc_menu .= '</ul>
					</li>';				
	endwhile;
	$acc_menu .= '</ul>';	
	
	
//корзина
	$s = sql("SELECT SUM(qty), SUM(qty*price) FROM basket WHERE tmp_usr='$tmp_user_id'");
	$r = mysql_fetch_array($s);
	if ($r[0] > 0):
		$bas_content = '<table width="100%">
						<tr><td align="left">В корзине: '.number_format($r[0], 0).' шт.<br>На сумму: '.number_format($r[1], 2, '.', ' ').'р</td>
						</tr>
						<tr><td ><a href="'.$site_url.'/basket.html" class="btn btn-info "><i class="icon-shopping-cart icon-white"></i> Перейти в корзину</a></td>
						</tr>
						</table>';
	else:
		$bas_content = '<i class="icon-shopping-cart"></i> Корзина пуста';	
	endif;

$tpl->assign(array(TPL_MAIN   => $tpl_main,
                   TITLE      => $title,
                   META_KEY   => $meta_key,
                   META_DESCR => $meta_descr,
				   _SITE_ => $site_url,
				   auth_form_action => $auth_form_action,
				   bas_content  => $bas_content,
				   OEM_MENU => $oem_menu,
				   ACC_MENU => $acc_menu,
           GOROD => $gorode,
				   srh_txt => ''
				));

$tpl->parse(TPL_HEADER, "header");
$tpl->parse(TPL_FOOTER, "footer");
$tpl->parse(TPL_MAIN, "main");
/*
$filename=basename($_SERVER['PHP_SELF']);
$temptime=filemtime($filename);
$temptime=$temptime-round($temptime/86400)*86400;
header("Last-modified: ".gmdate("D, d M Y H:i:s", $temptime+round(time()/86400)*86400-date("w")*86400)." GMT");
*/
$tpl->FastPrint();