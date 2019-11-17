<?php
include_once "ajax.php";
include_once '../FirePHP.class.php';

if(isset($_GET['get_codes'])){
    $s = sql("SELECT * FROM (SELECT DISTINCT d.code as code, g.name as brand_name FROM detali d
            INNER JOIN price_group g ON g.id=d.group_id AND g.id<>10
            WHERE g.name='Johnson'
            UNION 
            SELECT DISTINCT p.code as code, b.name_prc as brand_name FROM wn_parts p 
            INNER JOIN w_brand b ON b.id=p.brand_id
            WHERE b.name_prc='Johnson' ) q ORDER BY q.code
            ");
   
    $info = array();
    while ($r = mysql_fetch_array($s)) {
        $info [] = $r;
        //sql("INSERT INTO detail_code_boats (code, brand_name) VALUES ('".$r['code']."', '".$r['brand_name']."')");
    }
    echo json_encode(["info"=> count($info) > 0 ? $info : null]);
    exit();
}
else if(isset($_GET['check_ip'])){
	$ip = $_POST['ip'];
	
	$s = sql("SELECT count(*) as count FROM proxy_ip WHERE ip='$ip'");
	$r = mysql_fetch_array($s);
	
	$res = false;
	
	if($r['count'] == 0){	
		sql("INSERT INTO proxy_ip (ip) VALUES ('$ip') ");
		$res = true;
	}
	
	echo json_encode(["res"=> $res]);
    exit();
}
else if(isset($_GET['handle_groups'])){
	
	$s = sql("SELECT name, id FROM oem_brand");		
	$res = false;
	
	while($r = mysql_fetch_array($s)){	
		sql("UPDATE oem_group_1 g SET name=CONCAT(vehicle_name, ' ', '".$r['name']."') WHERE car_base_brand_id='".$r['id']."' ");
		$res = true;
	}
	
	echo json_encode(["res"=> $res]);
    exit();
}
else if(isset($_GET['check_oem'])){
    $p = 'is_checking_site_oem_running_throw_'.$_POST['throw'];
    
    $s = sql("SELECT value FROM param WHERE type='$p'");
    $r = mysql_fetch_array($s);
    
    $t = 'last_date_time_check_oem_throw_'.$_POST['throw'];
    
    $res = sql("SELECT IF (( TIMESTAMPDIFF(MINUTE, value, NOW()) > 5 ), 1, 0) as result FROM param WHERE type='$t' ");
    $row = mysql_fetch_array($res);
    
    echo json_encode(["res"=> (int)$r['value'] == 0 || $row['result'] == 1]);
    exit();
}
else if(isset($_GET['handle_details'])){
    $s = sql("SELECT * FROM detail_info_boats ");
   
    $info = array();
    while ($r = mysql_fetch_array($s)) {
        $ss = sql("SELECT * FROM detail_info_test WHERE detail_code='".$r['detail_code']."' AND brand_name='".$r['brand_name']."' ");
        $row = mysql_fetch_array($ss);
        
        if($row == false){
            sql("INSERT INTO detail_info_test (detail_code, brand_name, price_usd, weight, name_eng) VALUES ('".$r['detail_code']."', '".$r['brand_name']."', '".$r['price_usd']."', '".$r['weight']."', '".$r['name_eng']."')");
        }
        else{
            sql("UPDATE INTO detail_info_test (price_usd, weight) VALUES ('".$r['price_usd']."', '".$r['weight']."')");            
        }        
    }
    echo json_encode(["info"=> "ok"]);
    exit();
}
else if(isset($_GET['get_detail_links'])){
    $brand_name = $_POST['brand_name'];
    
    $s = sql("SELECT code FROM detail_code WHERE brand_name='$brand_name' ORDER BY code ASC");
    $links = array();
    
    while ($r = mysql_fetch_array($s)):
        $links [] = '<a href="{site_url}/supplier/'.$brand_name.'/'.$r["code"].'.html">{site_url}/supplier/'.$brand_name.'/'.$r["code"].'.html</a>';
    endwhile;
    
    $file = 'links.txt';
    $current = file_get_contents($file);
    $current .= implode('', $links);
    file_put_contents($file, $current);

    exit();
}
else if(isset($_GET['get_to_check'])){
    //$request = isset($_POST['offset']) ? $_POST['offset'] : 0;
    //$last_impex_run_field = 'get_last_impex_run_'.$request;
    //$s = sql("SELECT value FROM param WHERE type='$last_impex_run_field'");
    //$lastImpexRun = mysql_fetch_array($s);
    
    $codes = array();
    
    //if($lastImpexRun == false || $lastImpexRun['value'] == '0'){
        //$offset = $request * 300;
        $s = sql("SELECT TRIM(code) as code, TRIM(brand_name) as brand_name FROM detail_code WHERE  check_impex_date IS NULL ORDER BY code ASC LIMIT 200 ");

        while ($r = mysql_fetch_array($s)) {
            $codes[] = $r;  
        }
/*
        $param = 'count_handled_details_impex_'.$request;

        $s = sql("SELECT * FROM param WHERE type='$param' ");
        $r = mysql_fetch_array($s);

        if($r !== false){
            sql("UPDATE param SET value='".count($codes)."' WHERE type='$param' ");
        }
        else{
            sql("INSERT INTO param (type, value) VALUES ('$param', '".count($codes)."') ");
        } 
        */
        //setLastImpexRun($request, '1');
    //}        
    
    echo json_encode(["codes"=> count($codes) > 0 ? $codes : null]);
    exit();
}
else if(isset($_GET['set_impex_arr'])){
    $info = json_decode($_GET['data'], TRUE);
    
    foreach ($info as $key => $data) {
        if(count($data['original_parts']) > 0){
            $original = $data['original_parts'];
            foreach ($original as $key => $value) {
                //isDetailAlreadyAdded($value, $_POST['brandName'], $_POST['code']) ? setDetailInfo($value, $_POST['brandName'], $_POST['code']) : 
                    addDetailInfo($value, $data['brandName'], $data['code']);
            }
        }

        if(count($data['replacement_parts']) > 0){
            $replacements = $data['replacement_parts'];
            foreach ($replacements as $key => $value) {
                //isDetailAlreadyAdded($value, $_POST['brandName'], $_POST['code']) ? setDetailInfo($value, $_POST['brandName'], $_POST['code']) : 
                    addDetailInfo($value, $data['brandName'], $data['code']);
            }
        }

        if(count($data['original_parts']) == 0 && count($data['replacement_parts']) == 0){
            sql("INSERT INTO detail_info (brand_name, detail_code) VALUES ('".($data['brandName'])."', '".($data['code'])."')");
        }

        sql("UPDATE detail_code SET check_impex_date=now() WHERE code='".($data['code'])."' ");
    }
    
    exit();
}
else if(isset($_GET['set_impex_info'])){    
    $request = isset($_POST['offset']) ? $_POST['offset'] : 0;
    setLastDetailCheckTime($request);
    $startTime = microtime_float();
    $data = json_decode($_POST['data'], TRUE);
    $brandName = trim($_POST['brandName']);
    $code = trim($_POST['code']);
    $text = $brandName.' - '.$code;
    
    if(count($data['original_parts']) > 0){
        $original = $data['original_parts'];
        foreach ($original as $key => $value) {
            $text .= $value['name_eng'].' '.$value['mark'];
            //isDetailAlreadyAdded($value, $_POST['brandName'], $_POST['code']) ? setDetailInfo($value, $_POST['brandName'], $_POST['code']) : 
            //    addDetailInfo($value, $brandName, $code);
            isDetailAlreadyAdded($value, $brandName, $code) ? setDetailInfo($value, $brandName, $code) : addDetailInfo($value, $brandName, $code);
        }
    }
    
    if(count($data['replacement_parts']) > 0){
        $replacements = $data['replacement_parts'];
        foreach ($replacements as $key => $value) {
            $text .= $value['name_eng'].' '.$value['mark'];
            //isDetailAlreadyAdded($value, $_POST['brandName'], $_POST['code']) ? setDetailInfo($value, $_POST['brandName'], $_POST['code']) : 
            //    addDetailInfo($value, $brandName, $code);
            isDetailAlreadyAdded($value, $brandName, $code) ? setDetailInfo($value, $brandName, $code) : addDetailInfo($value, $brandName, $code);
        }
    }
    
    if(count($data['original_parts']) == 0 && count($data['replacement_parts']) == 0){
        $text .= ' empty value';
        //sql("INSERT INTO detail_info (brand_name, detail_code) VALUES ('".($_POST['brandName'])."', '".($_POST['code'])."')");
        sql("INSERT INTO detail_info (brand_name, detail_code) VALUES ('$brandName', '$code')");
    }
    
    $endTime = microtime_float();
    $interval = ($endTime - $startTime);    
    
    if(isset($data['replacement_parts'])){
        sql("INSERT INTO log (detail_code, brand_name, time, created, site, text) VALUES('$code', '$brandName', '$interval', NOW(), 'impex', '".$text."')");          
        sql("UPDATE detail_code SET check_impex_date=now() WHERE brand_name='$brandName' AND code='$code' ");
    }
    else{
        sql("INSERT INTO log (detail_code, brand_name, time, created, site, text) VALUES('$code', '$brandName', '$interval', NOW(), 'impex', 'errrrrrrrrrrrrrrrrroooooooooooooooooorrrrrrrrrrrrr')");            
    }
    
    //$param = 'count_handled_details_impex_'.$request;
    //sql("UPDATE param SET value=value-1 WHERE type='$param' ");    
    
    //echo json_encode(array("res"=> "ok"));
    exit();
}
else if(isset($_GET['set_boats_info'])){
    $code = $_POST['code'];
    $brandName = $_POST['brand_name'];
    
    $curl = curl_init('http://www.boats.net/parts/detail/'.strtolower($brandName).'/'.substr($brandName, 0, 1).'-'.$code.'.html');
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($curl,CURLOPT_USERAGENT,'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.13) Gecko/20080311 Firefox/2.0.0.13');
    $page = curl_exec($curl);
    
    if(!empty($curl) && $page !=''){

        $pokemon_doc = new DOMDocument;
        libxml_use_internal_errors(true);
        $pokemon_doc->loadHTML($page);
        libxml_clear_errors();

        $pokemon_xpath = new DOMXPath($pokemon_doc);
        
        $price = $pokemon_xpath->evaluate('string(//span[@id="product_price"])');
        $name = $pokemon_xpath->evaluate('string(//div[@id="product-info"]/h1)');
        $detailName = substr($name, strpos($name, " ") + 1);
        
        if($price !== '' && (float)(substr($price, 1)) > 0){
            $s = sql("SELECT * FROM detail_info WHERE brand_name='$brandName' AND detail_code='$code'");

            if(mysql_num_rows($s) > 0){
                sql("UPDATE detail_info SET price_usd='". (htmlspecialchars(substr($price, 1))) ."' WHERE brand_name='$brandName' AND detail_code='$code'");
            }
            else{
                sql("INSERT INTO detail_info (brand_name, detail_code, name_eng, price_usd)
                VALUES ('$brandName', '$code', '".($detailName)."', '". (htmlspecialchars(substr($price, 1))) ."')");
            }
        
        }
        sql("UPDATE detail_code SET check_boats_date=now() WHERE code='$code'");
    }
    exit();
}
else if(isset($_GET['add_detail_boats'])){
    $s = sql("SELECT * FROM detail_code_boats WHERE brand_name='".$_POST['brand_name']."' AND code='".$_POST['code']."'");

    if(mysql_fetch_array($s) == false){
        sql("INSERT INTO detail_code_boats (brand_name, code) VALUES ('".$_POST['brand_name']."', '".$_POST['code']."')");
    }
    
    exit();
}
else if(isset($_GET['stop_handling_boardtracker'])){
    sql("UPDATE param SET value=1 WHERE type='stop_checking_site_boardtracker'");
}
else if(isset($_GET['stop_handling_impex'])){
    sql("UPDATE param SET value=1 WHERE type='stop_checking_site_impex'");
}
else if(isset($_GET['clear_proxy_impex'])){
    sql("DELETE FROM param WHERE type LIKE 'ip_impex-%'");
}
else if(isset($_GET['add_proxy'])){
    $s = sql("SELECT COUNT(*) as count FROM proxy_ip WHERE ip='".trim($_POST['proxy_name'])."'");
    $r = mysql_fetch_array($s);
    
    if($r['count'] == 0){
        sql("INSERT INTO proxy_ip (ip, is_active) VALUES ('".$_POST['proxy_name']."', 0)");
        $res = 'ok';
    }  
    else{
        $res = 'already_added';
    }
    
    echo json_encode(["res"=> $res]);
    exit();
}
else if(isset($_GET['start_handling_boardtracker'])){
    //sql("UPDATE check_details SET should_stop=1 WHERE type='boats'");
    sql("UPDATE param SET value='0' WHERE type='stop_checking_site_boardtracker'");
    //sql("UPDATE param SET value='0' WHERE type='is_checking_site_boats_running'");
}
else if(isset($_GET['stop_handling_oem'])){
    sql("UPDATE param SET value='1' WHERE type='stop_checking_site_oem'");
}
else if(isset($_GET['start_handling_oem'])){
    sql("UPDATE param SET value='0' WHERE type='stop_checking_site_oem'");
}
else if(isset($_GET['set_oem'])){
    sql("UPDATE param SET value='0' WHERE type='is_checking_site_oem_running'");
}
else if(isset($_GET['start_handling_impex'])){
    sql("UPDATE param SET value=0 WHERE type='stop_checking_site_impex'");
    //sql("UPDATE param SET value='0' WHERE type='is_checking_site_impex_running'");
}
else if(isset($_GET['get_proxy_list'])){
    $s = sql("SELECT * FROM proxy_ip ORDER BY is_active DESC, is_banned ASC, is_bad ASC, ip ASC");
    $proxies = array();
    
    while ($r = mysql_fetch_array($s)) {
        $proxies[] = $r;  
    }
    
    echo json_encode(["proxies"=> count($proxies) > 0 ? $proxies : null]);
    exit();
}
else if(isset($_GET['ban_proxy'])){
    sql("UPDATE proxy_ip SET is_active=0, is_banned=1 WHERE id='".($_POST['id'])."'");
    
    echo json_encode(["res"=> "ok"]);
    exit();
    
}
else if(isset($_GET['pause_proxy'])){
    sql("UPDATE proxy_ip SET is_paused=1, is_active=0 WHERE id='".($_POST['id'])."'");
    
    echo json_encode(["res"=> "ok"]);
    exit();
    
}
else if(isset($_GET['cancel_pause_proxy'])){
    sql("UPDATE proxy_ip SET is_paused=0 WHERE id='".($_POST['id'])."'");
    
    echo json_encode(["res"=> "ok"]);
    exit();
    
}
else if(isset($_GET['cancel_proxy_ban'])){
    sql("UPDATE proxy_ip SET is_banned=0 WHERE id='".($_POST['id'])."'");
    
    echo json_encode(["res"=> "ok"]);
    exit();
    
}
else if(isset($_GET['cancel_proxy_bad'])){
    sql("UPDATE proxy_ip SET is_bad=0 WHERE id='".($_POST['id'])."'");
    
    echo json_encode(["res"=> "ok"]);
    exit();
    
}
else if(isset($_GET['bad_proxy'])){
    sql("UPDATE proxy_ip SET is_bad=1 WHERE id='".($_POST['id'])."'");
    
    echo json_encode(["res"=> "ok"]);
    exit();
}
else if(isset($_GET['set_proxy_activity'])){
    sql("UPDATE proxy_ip SET is_active='".( $_POST['activity'] == 'stop' ? 0 : 1)."' WHERE id='".($_POST['id'])."'");
    
    if($_POST['activity'] == 'activate'){
        sql("UPDATE proxy_ip SET start_use=now() WHERE id='".($_POST['id'])."'");
    }
    
    echo json_encode(["res"=> "ok"]);
    exit();
}
else if(isset($_GET['remove_proxy'])){
    sql("DELETE FROM proxy_ip WHERE id='".($_POST['id'])."'");
    
    echo json_encode(["res"=> "ok"]);
    exit();
}
else if(isset($_GET['set_impex'])){
    //sql("UPDATE check_details SET is_running=0 WHERE type='impex'");
    //sql("UPDATE param SET value='impex' WHERE type='checking_site'");
    sql("UPDATE param SET value='0' WHERE type='is_checking_site_impex_running'");
}
else if(isset($_GET['set_boardtracker'])){
    sql("UPDATE param SET value='0' WHERE type='is_checking_site_boardtracker_running'");
    //sql("UPDATE check_details SET is_running=0 WHERE type='boats'");    
}
else if(isset($_GET['get_last_impex_run'])){
    //$offset = isset($_POST['offset']) ? $_POST['offset'] : 0;
    
    //$param = 'last_date_time_check_impex_'.$offset;
    $s = sql("SELECT IF (( TIMESTAMPDIFF(SECOND, value, NOW()) > 20 ), 1, 0) as result FROM param WHERE type='last_date_time_check_impex' ");
    $r = mysql_fetch_array($s);

    /*
    $type = 'count_handled_details_impex_'.$offset;
    $_s = sql("SELECT value FROM param WHERE type='$type' ");
    $row = mysql_fetch_array($_s);
    */
    
    // (int)$row['value'] <= 0 || 
    
    echo json_encode(["res"=> (int)$r['result'] === 1 ? '1' : '0']);
    exit();
}
/*
else if(isset($_GET['get_last_impex_run'])){
    $s = sql("SELECT IF (( TIMESTAMPDIFF(MINUTE, value, NOW()) > 2 ), 1, 0) as result FROM param WHERE type='last_date_time_check_impex' ");
    $r = mysql_fetch_array($s);
    
    echo json_encode(["res"=> (int)$r['result'] == 1 ? '1' : '0']);
    exit();
}
 */
else if(isset($_GET['check_is_something_to_check'])){
    
    $res = sql("SELECT COUNT(*) as count FROM detail_code WHERE check_impex_date IS NULL");
    $row = mysql_fetch_array($res);
    echo json_encode(["res"=> (int)$row['count'] > 0 ? '1' : '0']);
    exit();
}

function setLastImpexRun($offset, $value){
    
    $last_impex_run = 'get_last_impex_run_'.$offset;
    $s = sql("SELECT value FROM param WHERE type='$last_impex_run'");
    $lastImpex = mysql_fetch_array($s);
    
    if($lastImpex == false){
        sql("INSERT INTO param (type, value) VALUES ('$last_impex_run', '$value')");
    }
    else{
        sql("UPDATE param SET value='$value' WHERE type='$last_impex_run'");
    }     
}

function getUnhandledDetail(){
    $s = sql("SELECT COUNT(*) as count FROM detail_code WHERE is_handled=1 ");
    $r = mysql_fetch_array($s);
    return (int)$r['count'];
}

function setLastDetailCheckTime($request){
    //$param = 'last_date_time_check_impex_'.$request;
    /*$s = sql("SELECT value FROM param WHERE type='$param'");
    $r = mysql_fetch_array($s);
    
    if($r == false){
        sql("INSERT INTO param (type, value) VALUES ('$param', 'now()')");
    }
    else{
        */
        sql("UPDATE param SET value=now() WHERE type='last_date_time_check_impex' ");  
    //}    
}

function isDetailAlreadyAdded($detail, $brandName, $code){
    $s = sql("SELECT * FROM detail_info WHERE mark= '".trim($detail['mark'])."' AND part_id='".trim($detail['part'])."' AND brand_name='$brandName' AND detail_code='$code'");
            
    return mysql_num_rows($s) > 0;
}

function setDetailInfo($detail, $brandName, $code){
    sql("UPDATE detail_info SET is_original='".($detail['is_original'] == false ? 0 : 1 )."',
        name_eng='".htmlspecialchars($detail['name_eng'])."', name_rus='".htmlspecialchars($detail['name_rus'])."',
        price_yen='".htmlspecialchars($detail['price_yen'])."', price_rub='".htmlspecialchars($detail['price_rub'])."',
        weight='".htmlspecialchars($detail['weight'])."', is_discontinued='".($detail['is_discontinued'] == false ? 0 : 1)."' WHERE brand_name='$brandName' AND detail_code='$code'");
}

function addDetailInfo($detail, $brandName, $code){
    sql("INSERT INTO detail_info (is_original, mark, brand_name, detail_code, part_id, name_eng, name_rus, price_yen,
        price_rub, weight, is_discontinued, alt_mark, alt_part)
        VALUES ('".($detail['is_original'] == false ? 0 : 1 )."', '".htmlspecialchars($detail['mark'])."',
        '$brandName', '$code', '".htmlspecialchars($detail['part'])."', '".( trim($detail['name_eng']))."',
        '".(htmlspecialchars($detail['name_rus']))."', '".htmlspecialchars($detail['price_yen'])."', '".htmlspecialchars($detail['price_rub'])."',
        '".htmlspecialchars($detail['weight'])."',
        '".($detail['is_discontinued'] == false ? 0 : 1)."',
        '".(isset($detail['alt_mark']) ? $detail['alt_mark'] : '')."',
        '".(isset($detail['alt_part']) ? $detail['alt_part'] : '')."'
          )");
}

function microtime_float(){
    list($usec, $sec) = explode(" ", microtime());
    return ((float)$usec + (float)$sec);
}