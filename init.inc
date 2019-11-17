<?php
  $debug = true;
  setlocale(LC_ALL, 'ru_RU.UTF-8');
  require_once "config.php";

  $DB = mysql_pconnect('95.183.13.61', 'motodobro_moto', 'w09UwdgJQ6');
  if (!$DB): die('Ошибка соединения с БД: ' . mysql_error()); endif;
  mysql_select_db('motodobro_moto',$DB);
  $site_url = 'http://' . $_SERVER['HTTP_HOST'];
  $acc_img_url = $site_url. '/pics/acc_img/';
  $acc_chart_img_url = $site_url. '/pics/acc_chart/';

  mysql_query("SET NAMES utf8");
  
  
  $site_name = '"Мото Добро"';
  $site_mail = 'info@motodobro.ru';
	//$site_mail = 'Automost-net@yandex.ru';



//  $user_id = 27;

function sql($command) {
    global $DB, $debug;
    $r = mysql_query($command, $DB);
    if (!$r && $debug):
        echo('<h4><font color="brown">Ошибка запроса: ' . mysql_error() . '</font></h4>');
    endif;
    if (!$r && $debug):
        echo('<h4><font color="darkcyan">SQL:' . $command . '</font></h4>');
    endif;
    return $r;
}

function myround($number) {
   // $drob=intval(( $number*100 - intval($number)*100 ));
   $tsel=intval($number);
   $drob=$number - $tsel;
   $drob=intval($drob*100);
   // echo $tsel .' -> '. $drob.   '<br>';
   return $tsel + ($drob/100);
}

function user_track () {
    global $mySesID;
    if (!isset($_COOKIE['mySesID'])):
        $mySesID = uniqid("");
        setcookie('mySesID', $mySesID, time()+60*60*24*365*3);
    else: 
        $mySesID = $_COOKIE['mySesID'];
    endif;    
    return $mySesID;
}

function encodestring($string) 
  { 
    $table = array( 
                'А' => 'A', 
                'Б' => 'B', 
                'В' => 'V', 
                'Г' => 'G', 
                'Д' => 'D', 
                'Е' => 'E', 
                'Ё' => 'YO', 
                'Ж' => 'ZH', 
                'З' => 'Z', 
                'И' => 'I', 
                'Й' => 'J', 
                'К' => 'K', 
                'Л' => 'L', 
                'М' => 'M', 
                'Н' => 'N', 
                'О' => 'O', 
                'П' => 'P', 
                'Р' => 'R', 
                'С' => 'S', 
                'Т' => 'T', 
                'У' => 'U', 
                'Ф' => 'F', 
                'Х' => 'H', 
                'Ц' => 'C', 
                'Ч' => 'CH', 
                'Ш' => 'SH', 
                'Щ' => 'CSH', 
                'Ь' => '', 
                'Ы' => 'Y', 
                'Ъ' => '', 
                'Э' => 'E', 
                'Ю' => 'YU', 
                'Я' => 'YA', 

                'а' => 'a', 
                'б' => 'b', 
                'в' => 'v', 
                'г' => 'g', 
                'д' => 'd', 
                'е' => 'e', 
                'ё' => 'yo', 
                'ж' => 'zh', 
                'з' => 'z', 
                'и' => 'i', 
                'й' => 'j', 
                'к' => 'k', 
                'л' => 'l', 
                'м' => 'm', 
                'н' => 'n', 
                'о' => 'o', 
                'п' => 'p', 
                'р' => 'r', 
                'с' => 's', 
                'т' => 't', 
                'у' => 'u', 
                'ф' => 'f', 
                'х' => 'h', 
                'ц' => 'c', 
                'ч' => 'ch', 
                'ш' => 'sh', 
                'щ' => 'csh', 
                'ь' => '', 
                'ы' => 'y', 
                'ъ' => '', 
                'э' => 'e', 
                'ю' => 'yu', 
                'я' => 'ya',
                ' ' => '_',	
				'/' => '_',	
				'?' => '_',
				'&' => '_',
				'.' => '_',
				',' => '_',
    ); 

    $output = str_replace( 
        array_keys($table), 
        array_values($table),$string 
    ); 
	$output = urlencode($output); 
    return $output; 
} 
?>
