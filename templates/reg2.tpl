<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
	<li><a href="{_SITE_}/">Главная</a> <span class="divider">/</span></li><li class="active">Авторизация/Регистрация</li>
	</ul>
	<div class="row">
	<div class="span6 offset2 {hideauth}" id="intcapt">
		<h3>Войдите на сайт или <a href="#" class="drop-links-big" id="regclick">зарегистрируйтесь</a></h3>
		<h2>Авторизация.</h2>
	</div>
	<div class="span6 offset2 {hidereg}" id="regcapt">
		<h3><a href="#" class="drop-links-big" id="intclick">Войдите на сайт</a> или зарегистрируйтесь</h3>
		<h2>Регистрация</h2>
	</div>	
	</div>
	{MSG}
	<div class="row" >
		<div class="span6 offset3 {hideauth}" id="intfield">
		<form action="{auth_form_action}" method="post">
	
			<div>
				<label for="login">
				электронная почта
				</label>
				<input class="span3" name="login" id="login" type="text">
			</div>	
			<div>
				<label for="pass">
				пароль
				</label>
				<input class="span3" name="pass" id="pass" type="password">
			</div>				
			<div class="span4" style="padding-top:10px;">
			<center>
			<button class="btn btn-large btn-primary " type="submit">&nbsp;&nbsp;&nbsp;Войти&nbsp;&nbsp;&nbsp;</button>
			</center>
			</div>
			<div style="height:50px;">&nbsp;<br>&nbsp;<br>&nbsp;<br></div>
		</form>
		</div>
	</div>
	
	<div class="row" >
		<div class="span6 offset3 {hidereg}" id="regfield">
		<form id="regform" method="post" action="" onsubmit="yaCounter39186095.reachGoal ('registr');" >

			<div>
				<label for="name">
				Фамилия Имя Отчество
				</label>
				<input class="span4" name="name" id="name" type="text" value="{name}" required>
			</div>	
			<div>
				<label for="phone">
				телефон
				<small class="text-warning">+7 (123) 456-7890</small>
				</label>
				<input class="span3 input-mask-phone" name="phone" id="phone" type="text" value="{phone}" required>
			</div>	
			<div>
				<label for="mail">
				электронная почта
				</label>
				<input class="span3" name="mail" id="mail" type="text" value="{mail}" required>
			</div>		
			<div>
			<label class="checkbox" for="agree">
				<input type="checkbox" id="agree" name="agree"> C <a href="{_SITE_}/rightreg.html" class="drop-links">условиями</a> регистрации согласен
			</label>
			</div>	
			<div style="margin-top:10px;" class="g-recaptcha" data-sitekey="6Ldo4TkUAAAAABpEsR6wJNncGiYIEfPP_k235T_O"></div>
			<div class="span4" style="padding-top:10px;">
			<center>
			<button class="btn btn-large btn-primary " type="submit" name="enter">Зарегистрироваться</button>
			</center>
			</div>
		</form>
		<div style="height:50px;">&nbsp;<br>&nbsp;<br>&nbsp;<br></div>
		</div>
	</div>	
	</div>	 
</div>		
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.js"></script> 
<script type="text/javascript" src="{_SITE_}/js/jquery.maskedinput.js"></script> 
<script type="text/javascript">
$('.input-mask-phone').mask('+9 (999) 999-9999');

$( "#regclick" ).click(function() {
  $("#regcapt").toggleClass("hidden", false);
  $("#regfield").toggleClass("hidden", false);
  $("#intcapt").toggleClass("hidden", true);
  $("#intfield").toggleClass("hidden", true);
  
});

$( "#intclick" ).click(function() {  
  $("#intcapt").toggleClass("hidden", false);
  $("#intfield").toggleClass("hidden", false);
  $("#regcapt").toggleClass("hidden", true);
  $("#regfield").toggleClass("hidden", true);
});

$("#regform").validate({
			rules: {
				name: "required",
				phone: "required",
				mail: {
					required: true,
					email: true
				},
				agree: "required"
			},
			messages: {
				name: '<span class="label label-important">Пожалуйста, укажите своё имя</span>',
				phone: '<span class="label label-important">Пожалуйста, укажите номер телефона</span>',
				mail: '<span class="label label-important">Укажите адрес элетронной почты</span>',
				agree: '<span class="label label-important">Для регистрации необходимо согласится с условиями</span>'
			}
		});
</script>