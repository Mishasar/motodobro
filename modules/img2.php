<?php
    header('content-type: image/gif');
    $id = $_GET['id'];
    $_lnk = array(); $_lnk = split('_',$id);
    $s_dirr = $_lnk[0]; $s_file = $_lnk[1];

    $_img_f = 'http://www.statusmoto.ru/cimg/catalog_img/'.$s_dirr.'/'.$s_file.'.gif';
	//$_img_f = 'http://95.31.3.190:8080/catalog_img/'.$s_dirr.'/'.$s_file.'.gif';
    $size = @GetImageSize($_img_f);
    /*
    if (!$size):
      $_img_f = 'http://'.$_SERVER['HTTP_HOST'].'/img/default.gif';
      $size = @GetImageSize($_img_f);
    endif;
    */
    $src_width = $size[0];
    $src_height = $size[1];
    
    $im_src = @imagecreatefromgif ($_img_f);
    $im_dst = @imagecreatetruecolor($src_width, $src_height);
    imagecopyresampled($im_dst, $im_src, 0, 0, 0, 0, $src_width, $src_height, $src_width, $src_height);
    imagedestroy($im_src);
    //наносим водяной знак
    $watermark = imagecreatefrompng('wt_big.png');
    $watermark_width = imagesx($watermark);
    $watermark_height = imagesy($watermark);
    /*
    $x_ratio = $watermark_width / $watermark_height;
    
    $watermark_width = $src_width - 40;
    $watermark_height = ceil($x_ratio * $watermark_height);
    */

    imagecopyresampled($im_dst, $watermark, $src_width/2 - $watermark_width/2, $src_height/2 - $watermark_height/2, 0, 0, $watermark_width, $watermark_height, $watermark_width, $watermark_height);

    imagedestroy($watermark);



     imagegif($im_dst);
     imagedestroy($im_dst);
?>