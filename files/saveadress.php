<?php
session_start();
include_once('../init.inc');


if (isset($_SESSION['user_id']) && $_SESSION['user_id'] > 0) { $user_id = $_SESSION['user_id']; }

if ($user_id > 0) {
	if ( isset($_REQUEST['adress']) ) {
	   $d_name = mysql_escape_string ($_REQUEST['d_name']);
	   $d_zip = mysql_escape_string ($_REQUEST['d_zip']);   
	   $d_adress = mysql_escape_string ($_REQUEST['d_adress']);	
		//id, name, zip_code, adress, edit_date 
		$s = sql("SELECT id FROM client_deliv WHERE client_id=$user_id AND name='$d_name' AND adress='$d_adress'");  
		$r = mysql_fetch_array($s);	
		if ($r['id'] > 0) {
			sql("UPDATE client_deliv SET edit_date=NOW() AND zip_code='$d_zip' WHERE id=".$r['id']);
		} else {
			sql("INSERT INTO client_deliv (name, zip_code, adress, edit_date, client_id ) VALUES ('$d_name', '$d_zip', '$d_adress', NOW(), $user_id)");
		}		
	}
	
} 




?>