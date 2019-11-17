<?php
/**
 * exform v1.0
 * Lopulyak Oleg < ol_lo@ukr.net >
 * Created 10.02.2013 ( updated 15.09.2014 )
 */

if(!isset($_REQUEST["mf_path"]) && !isset($_REQUEST["mf_captcha_code"])) die("Restricted access");?>
<div class="exform_wrapper mform">
 <div class="exform_header"><?php echo $config->form_header;?></div>
 <form name="exform">
  <table>
   <tr class="mf_name">
	<td><?php echo $config->name_title;?></td>
	<td>
     <?php if(isset($field_value["name_err"])) :?><div class="err"><img src="<?php echo $_SESSION['mf_path'];?>imgs/error.gif" title="<?php echo $field_value["name_err"];?>" /></div><?php endif;?>
     <input type="text" name="mf_name" value="<?php echo $field_value["name"];?>" class="<?php echo $field_class["name"];?>"/>
    </td>
   </tr>
   <tr class="mf_phone">
	<td><?php echo $config->phone_title;?></td>
	<td>
     <?php if(isset($field_value["phone_err"])) :?><div class="err"><img src="<?php echo $_SESSION['mf_path'];?>imgs/error.gif" title="<?php echo $field_value["phone_err"];?>" /></div><?php endif;?>
     <input type="text" name="mf_phone" value="<?php echo $field_value["phone"];?>" class="<?php echo $field_class["phone"];?>"/>
    </td>
   </tr>
   <tr class="mf_email">
	<td><?php echo $config->email_title;?></td>
	<td>
    <?php if(isset($field_value["email_err"])) :?><div class="err"><img src="<?php echo $_SESSION['mf_path'];?>imgs/error.gif" title="<?php echo $field_value["email_err"];?>" /></div><?php endif;?>
    <input type="text" name="mf_email" value="<?php echo $field_value["email"];?>"  class="<?php echo $field_class["email"];?>"/>
   </td>
   </tr>
   <tr class="mf_message">
	<td><?php echo $config->message_title;?></td>
	<td><textarea type="text" name="mf_message"><?php echo $field_value["message"];?></textarea></td>
   </tr>
   <tr class="mf_captcha_img">
	<td><a href="#" onclick="document.getElementById('mf_captcha_<?php echo $_REQUEST["mf_theme"];?>').src='<?php echo $_SESSION['mf_path'];?>captcha/securimage_show.php?'+ Math.random(); return false"><?php echo $config->captcha_refresh;?></a></td>
	<td class="img lading"><img id="mf_captcha_<?php echo $_REQUEST["mf_theme"];?>" src="<?php echo $_SESSION['mf_path'];?>captcha/securimage_show.php" alt="" /></td>
   </tr>
   <tr class="mf_captcha_code">
	<td><?php echo $config->captcha_code;?></td>
	<td>
	 <input type="text" name="mf_captcha_code" size="10" maxlength="6" value="<?php echo $field_value["captcha"];?>"  class="<?php echo $field_class["captcha"];?>"/>
     <input type="text" name="user_name" class='name'/>
     <input type="hidden" name="mf_theme" value="<?php echo $_REQUEST["mf_theme"];?>" />
     <input type="hidden" name="send" value="yes" />
	</td>
   </tr>
   <tr class="mf_submit"><td colspan="2"><input type="button" value="<?php echo $config->close_title;?>"><input type="submit" value="<?php echo $config->submit_title;?>"></td></tr>
  </table>
 </form>
</div> 