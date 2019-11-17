<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>
	<h3>{h1}</h3>
	<form action="{_SITE_}/basket.html" method="post" style="padding:0px; margin:0px;" id="formOrder">
	<input type="hidden" name="order" value="ok">
	<table class="table table-hover">
		<thead>
            <tr>
                <th >&nbsp;</th>
				<th>код детали</th>
                <th>описание</th>
                <th>цена</th>
                <th>кол-во</th>
                <th>сумма</th>
				
            </tr>
		</thead>
		<tbody>						
      <!-- BEGIN DYNAMIC BLOCK: order_row -->
        <tr >
          <td width="32" align="center">{del}</td>
		  <td nowrap><b>{code}</b></td>
          <td>{descr}</td>
          <td nowrap>{price}</td>
          <td nowrap>{qty}</td>
          <td nowrap>{sum}</td>
          
        </tr>
      <!-- END DYNAMIC BLOCK: order_row -->
        <tr class="info">
          <td align="right" colspan="5">Итого:&nbsp;</td>
          <td nowrap>&nbsp;<b>{total_sum}</td>
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
			<a href="{_SITE_}/reg2.html" role="button" class="btn btn-primary pull-left"><i class="icon-ok icon-white"></i> Заказать</a><br><br><br>			
      <!-- END DYNAMIC BLOCK: order_done_no_reg -->	 
	

</div>
</div>

<script type="text/javascript">	
	$(function () { 
		$("[data-toggle='tooltip']").tooltip(); 
	});
	
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