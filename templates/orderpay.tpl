<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>
	<h3>{h1}</h3>
	{content}
	


<!-- BEGIN DYNAMIC BLOCK: order_done -->	
{prim}
<h3 style="text-align: left;margin-bottom:-15px;margin-top:25px;">Выбрать способ оплаты:</h3>
<div class="row-fluid">
    <div class="funkyradio">
        <div class="funkyradio-primary span4">
            <input type="radio" name="pay_type" id="pay_type1" value="1" checked/>
            <label for="pay_type1">Перевод на карту СберБанка</label>
        </div>
        <div class="funkyradio-primary span4">
            <input type="radio" name="pay_type" id="pay_type2" value="2" />
            <label for="pay_type2">Запросить реквизиты (для Юр.лиц)</label>
        </div>
        <div class="funkyradio-primary span4">
            <input type="radio" name="pay_type" id="pay_type3" value="3" disabled/>
            <label for="pay_type3">Оплата Visa/Master Card </label>
        </div>
    </div>
</div>
<div class="row-fluid">
    <ul class="nav nav-tabs hidden" id="myTab">
    <li class="hidden"><a href="#tab1" data-toggle="tab">1</a></li>
    <li class="hidden"><a href="#tab2" data-toggle="tab">2</a></li>
    <li class="hidden"><a href="#tab3" data-toggle="tab">3</a></li>
</ul>
    <br>
    <div class="tab-content">
        <div id="tab1" class="tab-pane fade in active">
            <!-- tab 1 -->
            <div class="span7">
                Номер карты: <span style="font-size:18px;color:#1e347b;">{card_num}</span><br>
                {card_info}
            </div>
            <div class="span5">
                <form class="well form-horizontal" id="adressform" onsubmit="yaCounter39186095.reachGoal ('oplata');">
                    <div class="row-fluid">
                        <div class="control-group">
                            <label class="control-label span3" for="input01" style="font-size:13px;line-height:15px;padding-top:0px;">Дата платежа</label>
                            <div class="controls span9">
                                  <input type="text" class="span12" id="input01" name="input01">
                            </div>
                        </div>					
                        <div class="control-group">
                            <label class="control-label span3" for="input02" style="font-size:13px;line-height:15px;padding-top:0px;">Сумма платежа</label>
                            <div class="controls span9">
                                  <input type="text" class="span12" id="input02" name="input02">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label span3" for="input03" style="font-size:13px;line-height:15px;">Ф.И.О.</label>
                            <div class="controls span9">
                                  <input type="text" class="span12" id="input03" name="input03">
                            </div>
                        </div>					

                        <button type="submit" class="btn btn-primary pull-right" style="margin-top:0px;height:30px;"><i class="icon-info-sign icon-white"></i> Подтвердить оплату </button>
                    </div>
                </form>
            </div>
        </div>
        <div id="tab2" class="tab-pane fade">
            <!-- tab 2 -->
            Мы вышлем Вам реквизиты для оплаты от юр. лица<br>
            <a href="#" onclick="getDocs();" class="btn btn-primary" style="margin-top:10px;"><i class="icon-question-sign icon-white"></i> Запросить счет </a>
        </div>
        <div id="tab3" class="tab-pane fade">
            <!-- tab 3 -->
            tab 3 text
        </div>
    </div>
</div>
<!-- END DYNAMIC BLOCK: order_done --> 
<br>	
<br>	
    {back}
</div>
</div>	
<br><br><br><br><br><br>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.js"></script> 
<script type="text/javascript" src="{_SITE_}/js/jquery.maskedinput.js"></script> 
<script type="text/javascript">
    $("#input01").mask("99.99.9999");

    $('input[type=radio][name=pay_type]').change(function() {
        if (this.value == '1') {
                        $('#myTab a[href="#tab1"]').tab('show');
        }
        else if (this.value == '2') {
            $('#myTab a[href="#tab2"]').tab('show');
        }
    });
	
    function getDocs() {
        $.ajax({
            url: "{_SITE_}/files/getdocs.php",
            data: "id={id}",
            cache: false,
            success: function(html){
                  $('#getOrder').modal();
                  $('#getOrder').on('hidden', function () {
                    location.href = '{_SITE_}/';
                  });			
            }
        });	
    }

    $("#adressform").validate({
        rules: {
                input01: "required",
                input02: "required",
                input03: "required"
        },
        messages: {
                input01: '<div style="margin-bottom:-20px;"><span class="label label-important">Пожалуйста, укажите дату</span></div>',
                input02: '<div style="margin-bottom:-20px;"><span class="label label-important">Пожалуйста, укажите сумму</span></div>',
                input03: '<div style="margin-bottom:-20px;"><span class="label label-important">Укажите Ф.И.О. плательщика</span></div>'
        },	
        submitHandler: function(form) {
                $.ajax({
                  url: "{_SITE_}/files/applypay.php",
                  data: "id={id}&input01="+$('#input01').val()+"&input02="+$('#input02').val()+"&input03="+$('#input03').val(),
                  cache: false,
                  success: function(html){
                      console.log('test');
                        $('#sendPay').modal();
                        $('#sendPay').on('hidden', function () {
                          location.href = '{_SITE_}/';
                        });			
                  }
                });	
        }
    });	
</script>	




<div class="modal hide fade" id="getOrder" >
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4>Ваш запрос принят!</h4>
  </div>
  <div class="modal-body">
    <p> <b>Спасибо за интерес проявленный к нашему магазину!</b> <br>
       В ближайшее время на e-mail указанный Вами при регистрации будет выслан счет</p>
	 <p>Далее Вы можете перейти в <a href="{_SITE_}/orders.html" class="drop-links">личный кабинет</a> или закрыть это окно и продолжить покупки.</p>
  </div>
  <div class="modal-footer">
	<button class="btn" data-dismiss="modal" aria-hidden="true">Закрыть</button>  
  </div>
</div>

<div class="modal hide fade" id="sendPay" >
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4>Подтверждение оплаты</h4>
  </div>
  <div class="modal-body">
    <p> <b>Спасибо, что сообщили нам об оплате!</b> <br>
       В ближайшее время на e-mail указанный Вами при регистрации будет выслано подтверждение о зачислении денег</p>
	 <p>Далее Вы можете перейти в <a href="{_SITE_}/orders.html" class="drop-links">личный кабинет</a> или закрыть это окно и продолжить покупки.</p>
  </div>
  <div class="modal-footer">
	<button class="btn" data-dismiss="modal" aria-hidden="true">Закрыть</button>  
  </div>
</div>	
