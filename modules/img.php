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
	
	$factor = 500 / $src_width;
    $dst_width = 500;
    $dst_height = $factor * $src_height;	
    
    $im_src = @imagecreatefromgif ($_img_f);
    $im_dst = @imagecreatetruecolor($dst_width, $dst_height);
    imagecopyresampled($im_dst, $im_src, 0, 0, 0, 0, $dst_width, $dst_height, $src_width, $src_height);
    imagedestroy($im_src);
    //наносим водяной знак
    $watermark = imagecreatefrompng('wt_big.png');
    $watermark_width = imagesx($watermark);
    $watermark_height = imagesy($watermark);
	$w_dst = $factor * imagesx($watermark);
	$h_dst = $factor * imagesy($watermark);
	$wat = @imagecreatetruecolor($w_dst, $h_dst);
	ImageSaveAlpha($wat, true);
    ImageAlphaBlending($wat, true);
    ImageFill($wat, 0, 0, ImageColorAllocate($wat, 255, 255, 255));	
	imagecopyresampled($wat, $watermark, 0, 0, 0, 0, $w_dst, $h_dst, $watermark_width, $watermark_height);
	imagedestroy($watermark);
    /*
    $x_ratio = $watermark_width / $watermark_height;
    
    $watermark_width = $src_width - 40;
    $watermark_height = ceil($x_ratio * $watermark_height);
    */

    imagecopyresampled($im_dst, $wat, $dst_width/2 - $w_dst/2, $dst_height/2 - $h_dst/2, 0, 0, $w_dst, $h_dst, $w_dst, $h_dst);

    imagedestroy($wat);



     imagegif($im_dst);
     imagedestroy($im_dst);
?>