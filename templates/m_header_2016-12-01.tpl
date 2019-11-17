        <div class="header">
			<div class="nav">
				<div class="wrapper js-scroll-menu">
					<div class="nav_item">
						<a href="{_SITE_}/#ourcompany">О компании</a>
					</div>
					<div class="nav_item">
						<a href="{_SITE_}/pay.html">Оплата</a>
					</div>
					
					<div class="nav_item">
						<a href="{_SITE_}/deliv.html">Доставка</a>
					</div>

					
					  <!-- BEGIN DYNAMIC BLOCK: enter_reg -->
					  
					  
					  <a class="btn pull-right" href="{_SITE_}/exit_.html" style="margin-left:6px;"><i class="icon-key icon-white"></i> Выход</a>
					  <a class="btn btn-success pull-right" href="{_SITE_}/orders.html" style="margin-left:50px;"><i class="icon-user icon-white"></i> Личный кабинет</a>
					  <!-- END DYNAMIC BLOCK: enter_reg -->
					  <!-- BEGIN DYNAMIC BLOCK: enter_no_reg -->		  
					  <a class="btn pull-right" href="{_SITE_}/register_.html" style="margin-left:6px;"><i class="icon-key icon-white"></i> Регистрация</a>
					  <a class="btn btn-warning pull-right" style="margin-left:50px;" href="#modalAuth" role="button" data-toggle="modal"><i class="icon-user icon-white"></i> Вход в кабинет</a>
					  
					  <!-- END DYNAMIC BLOCK: enter_no_reg -->						
				</div>
				
			</div>            
			<div class="wrapper cl" style="padding-bottom:10px;">
                <div class="row-fluid" >
				<div class="span2">
					<div class="logo" style="padding-top:10px;">
						<a href="/" title="На главную">
							<img src="{_SITE_}/img/logo_new.png" alt="Moto Dobro">
						</a>
						<span class="small">Интернет-магазин запчастей для мототехники</span>
					</div>
				</div>
                <div class="span3" style="padding-top:30px;padding-left:10px;">
					<div class="header_center">
						г.Москва, Сущевский вал<br>дом 5, строение 15
					</div>
				</div>
				<div class="span3" style="padding-top:30px;padding-right:10px;">
					<div class="header_center">
						Понедельник - Пятница<br>с 10.00 до 19.00
					</div>
				</div>
				<div class="span4">
					<div class="header_right">
						<span class="header_phone">
							Звоните <b>8 (800)-550-7077</b><br/><b>Звонок бесплатный</b><br/>
							Пишите <a href="mailto:info@motodobro.ru">info@motodobro.ru</a>
							</span>
							<div style="margin-top:10px;">
								<div class="alert alert-black" style="margin:0px;" id="bas_content">{bas_content}</div>	
							</div>
					</div>
				</div>
				</div>
				
				<div style="position: absolute; left: 0; right: 0; top: 0; bottom: 0; margin: auto; width: 310px; height: 32%; font: normal 20px/28px 'segoe_ui_light', sans-serif; color: #9E9E9E;"></div>
                <div class="header_shadow"></div>
            </div>
			<div class="nav" style="margin:0px; padding:0px;">
				<div class="wrapper" >
					<div class="row-fluid" >					 
					 <div class="span8" style="text-align: left; padding-top:8px;" >
					 <div class="nav_item" >
						<div class="btn-group">
						  <a data-toggle="dropdown" href="#" style="font-size:15px;">OEM запчасти <i class="icon-chevron-down"></i></a>
						  {OEM_MENU}
						</div>												
					 </div>
					 <div class="nav_item" >
						<div class="btn-group">
						  <a data-toggle="dropdown" href="#" style="font-size:15px;">Неоригинальные запчасти и аксессуары <i class="icon-chevron-down"></i></a>
							{ACC_MENU}
						</div>												
					 </div>					 
					 </div>
				 
					 <div class="span4">
						<div class="row-fluid" >
						<form action="{_SITE_}/srh_.html" method="post" style="padding:0px; margin:0px;">
						<div class="input-append span12" style="margin-top:4px;margin-bottom:4px;">
						  <input id="appendedInputButton" type="text" name="srh_txt" placeholder="Поиск товара по коду"><button class="btn" type="submit" style="height:30px;"><i class="icon-search"></i> Найти</button>
						</div>	
						</form>	
						</div>
					  </div>
		  
					</div>
				</div>			
			</div>
			
			
        </div>
		
<div class="modal hide fade" id="modalAuth" >
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    
  </div>
  <div class="modal-body">

	<form class="form-horizontal" action="{auth_form_action}" method="post" style="margin:0px;">
	  <div class="control-group">
		<label class="control-label" for="inputEmail">Логин</label>
		<div class="controls">
		  <input type="text" id="inputEmail" name="login" placeholder="Логин">
		</div>
	  </div>
	  <div class="control-group">
		<label class="control-label" for="inputPassword">Пароль</label>
		<div class="controls">
		  <input type="password" id="inputPassword" name="pass" placeholder="Пароль">
		</div>
	  </div>
		<div class="alert alert-info">
			<p>Если Вы забыли свой Логин или Пароль, попробуйте воспользуйтесь <a href="{_SITE_}/restore_.html" class="m_model" style="color: #ee641b;">формой восстановления пароля</a></p>
			<p>Если Вы еще не зарегистрировались на нашем сайте, пройдите, пожалуйста, <a href="{_SITE_}/register_.html" class="m_model" style="color: #ee641b;">процедуру регистрации</a>. Она не отнимет у Вас много времени.</p>      
		</div>		  
  </div>
<div class="modal-footer">
		  <button class="btn" data-dismiss="modal" aria-hidden="true">Закрыть</button>  
		  <button type="submit" class="btn btn-primary" name="enter"><i class="icon-user icon-white"></i> Войти на сайт</button>
		 
</div>		
	</form>

</div>			