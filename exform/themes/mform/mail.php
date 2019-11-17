<?php
/**
 *
 * mForm v1.0
 * Lopulyak Oleg < ol_lo@ukr.net >
 * Created 10.02.2013
 * 
 */
$message = '<html>
			<head>
				<style type="text/css">
					td{
						border-bottom:1px dotted #000000;
						border-left:none;
						border-right:none;
						padding:5px 10px;
						font-family:arial,sans-serif;
						font-size:14px;
					}
				</style>
			</head>
			<body>
				<table border="0">'; 
if (isset($_REQUEST["mf_name"])){
 $message .= '<tr><td><strong>'.$config->name_title.'</strong></td><td>'.$_REQUEST["mf_name"].'</td></tr>';
}
if (isset($_REQUEST["mf_phone"])){
 $message .= '<tr><td><strong>'.$config->phone_title.'</strong></td><td>'.$_REQUEST["mf_phone"].'</td></tr>';
}
if (isset($_REQUEST["mf_message"])){
$message .= '<tr><td><strong>'.$config->message_title.'</strong></td><td>'.$_REQUEST["mf_message"].'</td></tr>';
}
$message .= '	</table>
			</body>
			</html>';
?>