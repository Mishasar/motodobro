<?php
include_once('../init.inc');
// Формируем строчку с ip
$ip = $_SERVER['REMOTE_ADDR'];
$forward = getenv(HTTP_X_FORWARDED_FOR);
if (!empty($forward) && ($forward != $_SERVER['REMOTE_ADDR']))  $ip = $ip."/".$forward;
$image = imagecreate(140, 30); //Создаём картинку

//формируем цветовую схему
$white = imagecolorallocate($image, 255, 255, 255);
$gray = imagecolorallocate($image, 230, 230, 230);
$black = imagecolorallocate($image, 0, 0, 0);

//Формируем запись в базу
$string = mt_rand();
$string = substr(sha1($string), 0, 6);
$string = str_replace(array('0', 'O', 'o'), rand(1, 9), $string);

//Запускаем цикл, создаём фон картинки
for ($i=0; $i<25; $i++) {
  $x1 = rand(0,140);
  $y1 = rand(0,30);
  $x2 = rand(0,140);
  $y2 = rand(0,30);
  imageline($image, $x1, $y1, $x2, $y2 , $gray);
}

//Запускаем цикл, и выводим текст на картинку
for ($i=0; $i<6; $i++) {
 $size = rand(4, 5);
 $x = $x + rand(12 , 20);
 $y = rand(7 , 12);
 imagestring($image, $size, $x, $y, $string{$i} , $black);
}
$imgsrc = sha1($string); //Кодируем код

 
//Удаляем соответствующую строку из базы если такой ip уже есть.
sql("DELETE FROM reg WHERE ip LIKE '%".$ip."%'");
//Заносим запись в базу
sql("INSERT INTO reg (ip,data) VALUES ('".$ip."','".$imgsrc."')");

 
//Создаём заголовок
header('Content-type: image/png');
imagepng($image); //Выводим картинку
imagedestroy($image);//Освобождаем занимаемую рисунком память

?>