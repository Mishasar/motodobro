<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
	<li><a href="{_SITE_}/">Главная</a> <span class="divider">/</span></li><li class="active">Регистрация</li>
	</ul>
	<h3>Регистрация</h3>
	<ul class="nav-pills" id="myTab">
	  <li class="{active_fiz}"><a href="#tbl_fiz">Физическое лицо</a></li>
	  <li class="{active_jurr}"><a href="#tbl_jurr">Юридическое лицо</a></li>
	</ul>
	 
	<div class="tab-content">
	  <div class="tab-pane {active_fiz}" id="tbl_fiz">
	  
		<form action="{_SITE_}/register.html" method="post" name="tbl_fiz_form" class="form-horizontal">
		  <input type="hidden" name="face" value="fiz">
		  <fieldset>
			<legend>Регистрация физического лица</legend>	  
				{MSG}
				<div class="control-group">
					<label class="control-label" for="l_name">Фамилия</label>
					<div class="controls">
						<input type="text" id="l_name" name="l_name" value="{l_name}" placeholder="Введите Вашу Фамилию…" class="input-xlarge">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="f_name">Имя</label>
					<div class="controls">
						<input type="text" id="f_name" name="f_name" value="{f_name}" placeholder="Введите Ваше Имя…" class="input-xlarge">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="m_name">Отчество</label>
					<div class="controls">
						<input type="text" id="m_name" name="m_name" value="{m_name}" placeholder="Введите Ваше Отчество…" class="input-xlarge">
					</div>	
				</div>
				<div class="control-group">
					<label class="control-label" for="phone">Телефон(ы)</label>
					<div class="controls">
						<input type="text" id="phone" name="phone" value="{phone}" placeholder="Введите номера Ваших телефонов…" class="input-xxlarge">
					</div>	
				</div>
				<div class="control-group">
					<label class="control-label" for="mail">E-mail</label>
					<div class="controls">
						<input type="text" id="mail" name="mail" value="{mail}" class="input-xlarge">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="index">Почтовый индекс</label>
					<div class="controls">
						<input type="text" id="index" name="index" value="{index}" class="input-small">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="addr">Адрес доставки</label>
					<div class="controls">
						<textarea id="addr" name="addr" cols="70" rows="4" class="input-xxlarge">{addr}</textarea>
						<style type="text/css">
						  #addr { resize: none; }
						</style>
					</div>					
				</div>				
				<div class="control-group">
					<label class="control-label" for="pwd">Пароль</label>
					<div class="controls">
						<input id="pwd" name="pwd" value="{pwd}" type="password" class="input-xlarge">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="pwd_re">Подтверждение пароля</label>
					<div class="controls">
						<input id="pwd_re" name="pwd_re" value="{pwd_re}" type="password" class="input-xlarge">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="comment">Комментарий</label>
					<div class="controls">
						<textarea id="comment" name="comment" cols="70" rows="4" class="input-xxlarge">{comment}</textarea>
						<style type="text/css">#comment { resize: none; }</style>
					</div>					
				</div>
                
                <div class="control-group">
                 <label class="control-label" for="code">Защитный код</label>
				 <div class="controls">
                  <input type="text" id="code" name="code" value="{code}" class="input-small">
                  <img id="fcode" width="200" src="{_SITE_}/exform/captcha/securimage_show.php" alt="" />
                  <a href="#" onclick="document.getElementById('fcode').src='{_SITE_}/exform/captcha/securimage_show.php?'+ Math.random(); return false">Обновить</a>
                 </div>
                </div>	
				
				<div class="alert alert-info">
					  После регистрации Вы получите письмо на Ваш электронный адрес (E-Mail) с Вашим логином и паролем.
					  Ваш электронный адрес1 (E-Mail) в дальнейшем будет использоваться только для доставления Вам информации 
					  по сделанным заказам. Личные сведения, полученные в распоряжение интернет-магазина {SHOP_NAME} при 
					  регистрации или каким-либо иным образом, не будут без разрешения пользователей передаваться третьим 
					  организациям и лицам, за исключением ситуаций, когда этого требует закон или судебное решение.
				</div>
				<div class="control-group">
					<label class="checkbox">
					<input type="checkbox" name="cat_srch" id="cat_srch" onclick="ImAgree();" >
					Нажимая кнопку "Регистрация", я подтверждаю свою дееспособность, даю согласие на обработку своих персональных данных
					</label>
					<button type="submit" name="enter" id="enter" class="btn btn-inverse disabled"><i class="icon-user icon-white"></i> Регистация</button>
				</div>				
		  </fieldset>	
		</form>	  	  
	  
	  </div>
	  <div class="tab-pane {active_jurr}" id="tbl_jurr">
		<form action="{_SITE_}/register.html" method="post" name="tbl_jurr_form" class="form-horizontal " >
		  <input type="hidden" name="face" value="jurr">
		  <fieldset>
			<legend>Регистрация юридического лица</legend>	  
				{MSG}
				<div class="control-group">
					<label class="control-label" for="name">Название фирмы</label>
					<div class="controls">
						<select size="1" name="form" class="input-small">
						   <option value="ООО" selected >ООО</option>
						   <option value="ЗАО">ЗАО</option>
						   <option value="АО">АО</option>
						   <option value="ИП">ИП</option>
						   <option value="ЧП">ЧП</option>
						   <option value=""></option>
						</select>
						<input type="text" id="name" name="name" value="{name}" class="input-xlarge">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="phone">Телефон(ы)</label>
					<div class="controls">
						<input type="text" id="phone" name="phone" value="{phone}" placeholder="Введите номера Ваших телефонов…" class="input-xxlarge">
					</div>	
				</div>
				<div class="control-group">
					<label class="control-label" for="mail">E-mail</label>
					<div class="controls">
						<input type="text" id="mail" name="mail" value="{mail}" class="input-xlarge">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="inn">ИНН</label>
					<div class="controls">
						<input type="text" id="inn" name="inn" value="{inn}" class="input-xlarge">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="kpp">КПП</label>
					<div class="controls">
						<input type="text" id="kpp" name="kpp" value="{kpp}" class="input-large">
					</div>	
				</div>
				<div class="control-group">
					<label class="control-label" for="rass">Расчетный счет</label>
					<div class="controls">
						<input type="text" id="rass" name="rass" value="{rass}" class="input-xlarge">
					</div>					
				</div>
				<div class="control-group">
					<label class="control-label" for="bank">Банк</label>
					<div class="controls">
						<input type="text" id="bank" name="bank" value="{bank}" class="input-xxlarge">
					</div>	
				</div>
				<div class="control-group">
					<label class="control-label" for="bik">БИК</label>
					<div class="controls">
						<input type="text" id="bik" name="bik" value="{bik}" class="input-large">
					</div>					
				</div>
				<div class="control-group">
					<label class="control-label" for="kors">Кор. счет</label>
					<div class="controls">
						<input type="text" id="kors" name="kors" value="{kors}" class="input-xlarge">
					</div>	
				</div>				
				<div class="control-group">
					<label class="control-label" for="juradress">Юр. Адрес</label>
					<div class="controls">
						<input type="text" id="juradress" name="juradress" value="{juradress}" class="input-xxlarge">
					</div>	
				</div>								
				<div class="control-group">
					<label class="control-label" for="index">Почтовый индекс</label>
					<div class="controls">
						<input type="text" id="index" name="index" value="{index}" class="input-small">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="addr">Адрес доставки</label>
					<div class="controls">
						<textarea id="addr" name="addr" cols="70" rows="4" class="input-xxlarge">{addr}</textarea>
						<style type="text/css">
						  #addr { resize: none; }
						</style>
					</div>					
				</div>				
				<div class="control-group">
					<label class="control-label" for="pwd">Пароль</label>
					<div class="controls">
						<input id="pwd" name="pwd" value="{pwd}" type="password" class="input-xlarge">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="pwd_re">Подтверждение пароля</label>
					<div class="controls">
						<input id="pwd_re" name="pwd_re" value="{pwd_re}" type="password" class="input-xlarge">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="comment">Комментарий</label>
					<div class="controls">
						<textarea id="comment" name="comment" cols="70" rows="4" class="input-xxlarge">{comment}</textarea>
						<style type="text/css">
						  #comment { resize: none; }
						</style>
					</div>					
				</div>
                
				<div class="control-group">
                 <label class="control-label" for="code">Защитный код</label>
				 <div class="controls">
                  <input type="text" id="code" name="code" value="{code}" class="input-small">
                  <img id="ucode" width="200" src="{_SITE_}/exform/captcha/securimage_show.php" alt="" />
                  <a href="#" onclick="document.getElementById('ucode').src='{_SITE_}/exform/captcha/securimage_show.php?'+ Math.random(); return false">Обновить</a>
                 </div>
                </div>
                	
				
				<div class="alert alert-info">
					  После регистрации Вы получите письмо на Ваш электронный адрес (E-Mail) с Вашим логином и паролем.
					  Ваш электронный адрес (E-Mail) в дальнейшем будет использоваться только для доставления Вам информации 
					  по сделанным заказам. Личные сведения, полученные в распоряжение интернет-магазина {SHOP_NAME} при 
					  регистрации или каким-либо иным образом, не будут без разрешения пользователей передаваться третьим 
					  организациям и лицам, за исключением ситуаций, когда этого требует закон или судебное решение.
				</div>
				<div class="control-group">
					<label class="checkbox">
					<input type="checkbox" name="cat_srch_jurr" id="cat_srch_jurr" onclick="ImAgree();" >
					Нажимая кнопку "Регистрация", я подтверждаю свою дееспособность, даю согласие на обработку своих персональных данных
					</label>
					<button type="submit" name="enter" id="enter" class="btn btn-inverse disabled"><i class="icon-user icon-white"></i> Регистация</button>
				</div>				
		  </fieldset>	
		</form>	 	   
	  </div>
	</div>
	</div>	 
</div>		

<script type="text/javascript">
	$('#myTab a').click(function (e) {
	  e.preventDefault();
	  $(this).tab('show');
	});  
	
	function ImAgree() {
      if (document.tbl_fiz_form.cat_srch.checked) {
        document.tbl_fiz_form.enter.className='btn btn-inverse';
      } else {
        document.tbl_fiz_form.enter.className='btn btn-inverse disabled';
      }
      if (document.tbl_jurr_form.cat_srch_jurr.checked) {
        document.tbl_jurr_form.enter.className='btn btn-inverse';
      } else {
        document.tbl_jurr_form.enter.className='btn btn-inverse disabled';
      }

    }
</script>