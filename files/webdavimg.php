<?php
require_once 'phar://yandex-php-library_master.phar/vendor/autoload.php';
//require_once 'phar://yandex-php-library_1.0.0.phar/vendor/autoload.php';

use Yandex\Disk\DiskClient;
define('ACCESS_TOKEN', 'ARZxyJcAAxrOHKdcSBnGTZW1u2vrTrnz6A');
$diskClient = new DiskClient(ACCESS_TOKEN);
$diskClient->setServiceScheme(DiskClient::HTTPS_SCHEME);

$path = 'pics/big/1/1b011b3b337a83608bfd6b9e7ff5ab11_.gif';
$answ = $diskClient->getFile($path);

print_r($answ);
//header('content-type: ' . $answ['headers']['content-type']);
//echo $answ['body'];

//phpinfo();
?>