<div class="content">
<div class="wrapper">
	<ul class="breadcrumb">
	<li><a href="{_SITE_}/">Главная</a> <span class="divider">/</span></li><li class="active">Восстановление пароля</li>
	</ul>
	<h3>Восстановление пароля</h3>
	
		<form action="{_SITE_}/restore.html" method="post">
		  <input type="hidden" name="face" value="fiz">
		  <fieldset>
			<legend>Форма восстановления пароля</legend>	  
				{msg}
				<div class="control-group">
					<label class="control-label" for="mail">Адрес E-mail указанный при регистрации</label>
					<div class="controls">
						<input type="text" id="mail" name="mail" value="{mail}" class="input-xlarge">
					</div>
				</div>	
				<div class="control-group">
					<label class="control-label" for="secret">Введите код</label>
					 <div class="controls">
					  <input type="text" id="code" name="code" value="{code}" class="input-small">
					  <img id="fcode" width="200" src="{_SITE_}/exform/captcha/securimage_show.php" alt="" />
					  <a href="#" onclick="document.getElementById('fcode').src='{_SITE_}/exform/captcha/securimage_show.php?'+ Math.random(); return false">Обновить</a>
					 </div>					
				</div>	
				<div class="control-group">
					<input type="submit" name="enter" id="enter" value="&nbsp;&nbsp;ВОССТАНОВИТЬ ПАРОЛЬ&nbsp;&nbsp;" class="btn btn-inverse ">
				</div>					
		  </fieldset>	
		</form>		
</div>	
</div>	
        
