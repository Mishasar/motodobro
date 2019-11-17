<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>
	<h3>{h1}</h3>
	<form action="{_SITE_}/basket.html" method="post" style="padding:0px; margin:0px;" id="formOrder">
	<input type="hidden" name="order" value="ok">
	<table class="table table-bordered table-hover">
		<thead>
            <tr>
                <th>код детали</th>
                <th>описание</th>
                <th>цена</th>
                <th>кол-во</th>
                <th>сумма</th>
				<th>&nbsp;</th>
            </tr>
		</thead>
		<tbody>						
      <!-- BEGIN DYNAMIC BLOCK: order_row -->
        <tr >
          <td nowrap><b>{code}</b></td>
          <td>{descr}</td>
          <td nowrap>{price}</td>
          <td nowrap>{qty}</td>
          <td nowrap>{sum}</td>
          <td>{del}</td>
        </tr>
      <!-- END DYNAMIC BLOCK: order_row -->
        <tr class="info">
          <td align="right" colspan="4">Итого:&nbsp;</td>
          <td nowrap>&nbsp;<b>{total_sum}</td>
          <td >&nbsp;</td>
        </tr>	  
		<tbody>		
	</table>
	
     <!-- BEGIN DYNAMIC BLOCK: order_no_sum -->
		<div class="alert alert-error">
              <strong>Внимание!</strong> Минимальная сумма заказа <b>1000</b> рублей.
		</div>	  
     <!-- END DYNAMIC BLOCK: order_no_sum -->	
      <!-- BEGIN DYNAMIC BLOCK: order_done -->
			<div style="margin-top:-10px;">
              <input type="submit" name="update" value="Пересчитать корзину"  class="btn btn-inverse pull-right">
			</div>  <br>
     <!-- END DYNAMIC BLOCK: order_done --> 
	 
     <!-- BEGIN DYNAMIC BLOCK: order_done_reg -->
			<h3>Варианты доставки</h3>
			<select class="span3" name="deliv_type">
                    <option value="1" selected>Самовывоз из офиса</option>
                    <option value="2">Почта России</option>
                    <option value="3" >EMS Почта России</option>
                    <option value="4">Курьер (Москва и МО)</option>
                    <option value="5">Курьер (Санкт-Петербург)</option>
			
			</select>
			<span class="help-block">Выберите вариант доставки</span>
			<h3>Уведомления</h3>
			<input class="span3" size="11" type="text" name="sms_phone" value={sms_phone}> 11 цифр. Например: 89031252525 
			<span class="help-block">Укажите номер мобильного телефона для получения SMS уведомлений о состоянии Вашего заказа</span>
			<div class="alert alert-info">
				  Если Вы не желаете получать уведомления - оставьте это поле пустым.
			</div>			
			<br>
			<input type="submit" name="order" value="Сформировать заказ"  class="btn btn-primary pull-left"  onclick="sendOrder();"><br><br><br><br><br><br>
     <!-- END DYNAMIC BLOCK: order_done_reg --> 
	 
	</form>	 
      <!-- BEGIN DYNAMIC BLOCK: order_done_no_reg -->
			<h3>Необходима авторизация</h3>
			<a href="#modalAuth" role="button" class="btn btn-primary pull-left" data-toggle="modal"><i class="icon-user icon-white"></i> Войти на сайт</a><br><br><br>
			<div class="alert alert-block">
            <p>Если Вы забыли свой Логин или Пароль, попробуйте воспользуйтесь <a href="{_SITE_}/restore_.html" class="m_model" style="color: #ee641b;">формой восстановления пароля</a></p>
			<p>Если Вы еще не зарегистрировались на нашем сайте, пройдите, пожалуйста, <!--a href="/register_.html" class="m_model" style="color: #ee641b;" -->процедуру регистрации. Она не отнимет у Вас много времени.</p>      
			</div>	
			
			

				<h3>Регистрация</h3>
				<ul class="nav-pills" id="myTab">
					<li class="active"><a href="#tbl_fiz">Физическое лицо</a></li>
					<li class=""><a href="#tbl_jurr">Юридическое лицо</a></li>
				</ul>
			<div class="tab-content">
			<div class="tab-pane active" id="tbl_fiz">
	  
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
					  Ваш электронный адрес (E-Mail) в дальнейшем будет использоваться только для доставления Вам информации 
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
	  <div class="tab-pane " id="tbl_jurr">
		<form action="{_SITE_}/register.html" method="post" name="tbl_jurr_form" class="form-horizontal" >
		  <input type="hidden" name="face" value="jurr">
		  <fieldset>
			<legend>Регистрация юридического лица</legend>	  
				
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
						<input type="text" id="name" name="name" value="" class="input-xlarge">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="phone">Телефон(ы)</label>
					<div class="controls">
						<input type="text" id="phone" name="phone" value="" placeholder="Введите номера Ваших телефонов…" class="input-xxlarge">
					</div>	
				</div>
				<div class="control-group">
					<label class="control-label" for="mail">E-mail</label>
					<div class="controls">
						<input type="text" id="mail" name="mail" value="" class="input-xlarge">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="inn">ИНН</label>
					<div class="controls">
						<input type="text" id="inn" name="inn" value="" class="input-xlarge">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="kpp">КПП</label>
					<div class="controls">
						<input type="text" id="kpp" name="kpp" value="" class="input-large">
					</div>	
				</div>
				<div class="control-group">
					<label class="control-label" for="rass">Расчетный счет</label>
					<div class="controls">
						<input type="text" id="rass" name="rass" value="" class="input-xlarge">
					</div>					
				</div>
				<div class="control-group">
					<label class="control-label" for="bank">Банк</label>
					<div class="controls">
						<input type="text" id="bank" name="bank" value="" class="input-xxlarge">
					</div>	
				</div>
				<div class="control-group">
					<label class="control-label" for="bik">БИК</label>
					<div class="controls">
						<input type="text" id="bik" name="bik" value="" class="input-large">
					</div>					
				</div>
				<div class="control-group">
					<label class="control-label" for="kors">Кор. счет</label>
					<div class="controls">
						<input type="text" id="kors" name="kors" value="" class="input-xlarge">
					</div>	
				</div>				
				<div class="control-group">
					<label class="control-label" for="juradress">Юр. Адрес</label>
					<div class="controls">
						<input type="text" id="juradress" name="juradress" value="" class="input-xxlarge">
					</div>	
				</div>								
				<div class="control-group">
					<label class="control-label" for="index">Почтовый индекс</label>
					<div class="controls">
						<input type="text" id="index" name="index" value="" class="input-small">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="addr">Адрес доставки</label>
					<div class="controls">
						<textarea id="addr" name="addr" cols="70" rows="4" class="input-xxlarge"></textarea>
						<style type="text/css">
						  #addr { resize: none; }
						</style>
					</div>					
				</div>				
				<div class="control-group">
					<label class="control-label" for="pwd">Пароль</label>
					<div class="controls">
						<input id="pwd" name="pwd" value="" type="password" class="input-xlarge">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="pwd_re">Подтверждение пароля</label>
					<div class="controls">
						<input id="pwd_re" name="pwd_re" value="" type="password" class="input-xlarge">
					</div>					
				</div>	
				<div class="control-group">
					<label class="control-label" for="comment">Комментарий</label>
					<div class="controls">
						<textarea id="comment" name="comment" cols="70" rows="4" class="input-xxlarge"></textarea>
						<style type="text/css">
						  #comment { resize: none; }
						</style>
					</div>					
				</div>	
				
				<div class="alert alert-info">
					  После регистрации Вы получите письмо на Ваш электронный адрес (E-Mail) с Вашим логином и паролем.
					  Ваш электронный адрес (E-Mail) в дальнейшем будет использоваться только для доставления Вам информации 
					  по сделанным заказам. Личные сведения, полученные в распоряжение интернет-магазина PartsNetWeb.ru при 
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
			
			
			
      <!-- END DYNAMIC BLOCK: order_done_no_reg -->	 
	

</div>
</div>
<script type="text/javascript">	
	function sendOrder() {
		var options = {
        success:       showModal	
		};	
    $('#formOrder').submit(function() { 
        $(this).ajaxSubmit(options);  
        return false; 
    }); 
	}
  
function showModal()  { 
	$('#modalOrder').modal();
	$('#modalOrder').on('hidden', function () {
	  location.href = '{_SITE_}/';
	})	
}
</script>



<div class="modal hide fade" id="modalOrder" >
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4>Ваш заказ принят!</h4>
  </div>
  <div class="modal-body">
    <p> <b>Спасибо за покупку!</b> <br>
       После обработки заказа нашими менеджерами, он появится в Вашем кабинете в <a href="{_SITE_}/orders.html">списке заказов</a>, где Вы сможете следить 
       за сроками и качеством исполнения заказа.</p>
	 <p> Далее Вы можете перейти в <a href="{_SITE_}/orders.html">личный кабинет</a> или закрыть это окно и продолжить покупки. </p>
  </div>
  <div class="modal-footer">
	<button class="btn" data-dismiss="modal" aria-hidden="true">Закрыть</button>  
  </div>
</div>	