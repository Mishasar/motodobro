<div class="header">
    <div class="nav desctop">
        <div class="wrapper js-scroll-menu">
                <div class="nav_item" style="float: left;">
                    <div style="color: #fff;" class="cit5">Выберете город: <div id="city5">{GOROD}</div></div>
                </div>
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
                <a class="btn pull-right desctop" href="{_SITE_}/exit_.html" style="margin-left:6px;"><i class="icon-key icon-white"></i> Выход</a>
                <a class="btn btn-success pull-right desctop" href="{_SITE_}/orders.html" style="margin-left:50px;"><i class="icon-user icon-white"></i> Личный кабинет</a>
                <!-- END DYNAMIC BLOCK: enter_reg -->
                <!-- BEGIN DYNAMIC BLOCK: enter_no_reg -->		  
                <a class="btn pull-right desctop" href="{_SITE_}/reg2.html?enter=enter" style="margin-left:6px;"><i class="icon-key icon-white"></i> Регистрация</a>
                <a class="btn btn-warning pull-right desctop" style="margin-left:50px;" href="#modalAuth" role="button" data-toggle="modal"><i class="icon-user icon-white"></i> Вход в кабинет</a>
                <!-- END DYNAMIC BLOCK: enter_no_reg -->			
        </div>
    </div>
    <div class="navbar navbar-inverse phone">
        <div class="navbar-inner">
            <div class="container">                  
                <div style="float: left">   
                    <button type="button" class="btn btn-navbar btn-collapse" style="float: none;">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>                    
                </div>                
                <div style="display: inline">
                    <a href="/" title="На главную" style="color: white;">
                        <img src="{_SITE_}/img/logo_new.png" alt="Moto Dobro">
                    </a>
                </div>
                <div style="display: inline; float: right; margin-right: 30px; margin-top: 10px;">
                    <a href="{_SITE_}/basket.html"><i style="color:white;" class="fa fa-shopping-cart fa-3x"></i>
                        <span class="badge badge-warning basket-badge">{count_cart_items}</span>
                    </a>
                </div>
                <div class='notifications center'></div>
            </div>
            <div class="navbar-collapse">
                <ul>        
                    <li><a href="{_SITE_}/#ourcompany">О компании</a></li>
                    <li><a href="{_SITE_}/pay.html">Оплата</a></li>
                    <li><a href="{_SITE_}/deliv.html">Доставка</a></li> 
                    <!-- BEGIN DYNAMIC BLOCK: enter_reg -->
                    <li class="phone"><a href="{_SITE_}/exit_.html">Выход</a></li>
                    <li class="phone"><a href="{_SITE_}/orders.html">Личный кабинет</a></li>
                    <!-- END DYNAMIC BLOCK: enter_reg -->
                    <!-- BEGIN DYNAMIC BLOCK: enter_no_reg -->		  
                    <li class="phone"><a href="{_SITE_}/reg2.html?enter=enter" >Регистрация</a></li>
                    <li class="phone"><a href="#modalAuth" role="button" data-toggle="modal">Вход в кабинет</a></li>
                    <!-- END DYNAMIC BLOCK: enter_no_reg -->
                </ul>                    
            </div>
        </div>
    </div>
                  
    <div class="wrapper cl desctop" style="padding-bottom:10px;">
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
                        Отправка в регионы.<br>СДЭК, Почта России, <br>Деловые Линии
                    </div>
            </div>
            <div class="span3" style="padding-top:30px;padding-right:10px;">
                    <div class="header_center">
                        График: Пн-Пт: 10:00-19:00 <br>Эл. адрес: info@motodobro.ru <br>Телефон: +7 909 778 7073
                    </div>
            </div>
            <div class="span4">
                <div class="header_right">
                    <div style="margin-top:16px;">
                        <div class="alert alert-black" style="margin:0px;" id="bas_content">{bas_content}</div>	
                    </div>
                </div>
            </div>
        </div>
        <div style="position: absolute; left: 0; right: 0; top: 0; bottom: 0; margin: auto; width: 310px; height: 32%; font: normal 20px/28px 'segoe_ui_light', sans-serif; color: #9E9E9E;"></div>
        <div class="header_shadow"></div>
    </div>
    <div class="sub-menu nav" style="margin: 0; padding: 0">
        <div class="wrapper">
        <div class="row-fluid">
            <div class="span8 desctop" style="text-align: left; padding-top:8px;" >
                <div class="nav_item" >
                    <div class="btn-group">
                        <a data-toggle="dropdown" href="#" style="font-size:15px;">OEM запчасти <i class="icon-chevron-down"></i></a>
                        {OEM_MENU}
                    </div>												
                </div>
                <div class="nav_item" >
                    <div class="btn-group">
                        <a data-toggle="dropdown" href="#" style="font-size:15px;">Неоригинальные запчасти <i class="icon-chevron-down"></i></a>
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
                <p>Если Вы еще не зарегистрировались на нашем сайте, пройдите, пожалуйста, <a href="{_SITE_}/reg2.html" class="m_model" style="color: #ee641b;">процедуру регистрации</a>. Она не отнимет у Вас много времени.</p>
            </div>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Закрыть</button>  
        <button type="submit" class="btn btn-primary" name="enter"><i class="icon-user icon-white"></i> Войти на сайт</button>
		 
    </div>		
	</form>

</div>			
<script>
    window.timerId = null;
    window.intervalId = null;
    
    $(".btn-collapse").click(function(){
       $('.navbar-collapse').css('display', $('.navbar-collapse').css('display') === 'none' ? 'inline' : 'none');
    });
    
    $(document).ready(function () {
        //getCodesToAddInfo();
        //window.intervalId = setInterval(getLastDateTimeRunImpexCheck, 60000);
    });
  
    function getLastDateTimeRunImpexCheck(){
        $.post('/ajax/detail.php?get_last_impex_run').done(function(data){
            if(data.res === '1'){
                $.post('/ajax/detail.php?check_is_something_to_check')
                .done(function(data){
                    if(data.res === '1'){
                        getCodesToAddInfo();
                    }
                    else{
                        clearInterval(window.intervalId);
                    }
                });
            }
        });
        
    }
    function getDetailCodes(){
        $.post('/ajax/detail.php?get_codes');
    }
    
    function getDetailLinks(brand_name){
        var request = {
            brand_name:brand_name
        };
        $.post('/ajax/detail.php?get_detail_links',request);
    }
    
    function handleDetailCodes(codes, start_position){
        var countCodes = codes.length, detailInfo = [];
        
        for(var i in codes){
            
            $.getJSON('https://www.impex-jp.com/api/parts/search.html', {part_no: codes[i]['code']}).done(function (response) {
                -- countCodes;
                response['code'] = codes[i]['code'];
                response['brandName'] = codes[i]['brand_name'];
                
                detailInfo.push(response);
                $.getJSON('/ajax/detail.php?set_impex_arr', {data : JSON.stringify(detailInfo)});
            });
        }
        
        getDetailCodes(start_position + 100);
    }        
    
    function getCodesToAddInfo(){
        $.post('/ajax/detail.php?get_to_check')
        .done(function(data){
            if(data.codes && data.codes.length > 0){
                for(var i in data.codes){
                    checkImpexSiteByCode(data.codes[i]['code'], data.codes[i]['brand_name']);
                }      
            }
            else{
                clearTimeout(window.timerId);
            }
        })
        .fail(function(err) {
            console.log(err);
            getCodesToAddInfo();
        });
    }
       
    function checkImpexSiteByCode(code, brandName){
        var params = {
            part_no: code
        };
        $.getJSON('https://www.impex-jp.com/api/parts/search.html', params).done(function (response) {
            $.post('/ajax/detail.php?set_impex_info', {data : JSON.stringify(response), code : code, brandName : brandName})
            window.timerId = setTimeout(getCodesToAddInfo, 3000);
        });
    }
    
    function checkBoatsSiteByCode(code, brandName){
        var params = {
            code : code,
            brand_name : brandName
        };
        $.post('/ajax/detail.php?set_boats_info', params);
    }
    
</script>