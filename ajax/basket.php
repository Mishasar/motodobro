<?php
include_once "ajax.php";

$userId = user_track ();
if (!$userId)
{
    header("HTTP/1.0 401 Unauthorized");
    exit;
}

if(isset($_GET['get_users_products'])){
    $s = sql("SELECT SUM(qty) FROM basket WHERE tmp_usr='$userId'");
    $r = mysql_fetch_array($s);
    $count = $r[0] > 0 ? $r[0] : 0;
        
    echo json_encode(["count"=>$count]);
    exit();
}

