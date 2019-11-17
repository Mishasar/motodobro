<?php
if (isset($_REQUEST['file'])): $file = $_REQUEST['file']; else: $file = ''; endif;
if ($file == '') {
	$path = 'pics/big/default.gif';
} else {
	$file_path = explode('_', $file);
	if (count($file_path) == 2) {
		$path = 'pics/big/'.$file_path[0].'/'.$file_path[1].'.gif';
	} else {
		$path = 'pics/big/default.gif';	
	}	
}

//require_once 'phar://yandex-php-library_master.phar/vendor/autoload.php';
require_once 'phar://yandex-php-library_1.0.0.phar/vendor/autoload.php';



use Yandex\Disk\DiskClient;
define('ACCESS_TOKEN', 'ARZxyJcAAxrOHKdcSBnGTZW1u2vrTrnz6A');
$diskClient = new DiskClient(ACCESS_TOKEN);
$diskClient->setServiceScheme(DiskClient::HTTPS_SCHEME);

$answ = $diskClient->getFile($path);
header('content-type: ' . $answ['headers']['content-type']);
echo $answ['body'];

//phpinfo();
?>