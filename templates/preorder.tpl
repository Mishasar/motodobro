<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>
	<h3>Ваш заказ</h3>
	<form action="{_SITE_}/orderpay.html" method="post" style="padding:0px; margin:0px;" id="sendform">
	<input type="hidden" name="order" value="ok">
	<table class="table table-hover">
		<thead>
            <tr>
				<th>код детали</th>
                <th>описание</th>
                <th>кол-во</th>
                <th>сумма</th>	
            </tr>
		</thead>
		<tbody>						
      <!-- BEGIN DYNAMIC BLOCK: order_row -->
        <tr >
		  <td nowrap><b>{code}</b></td>
          <td>{descr}</td>
          <td nowrap>{qty}</td>
          <td nowrap>{sum}</td>
          
        </tr>
      <!-- END DYNAMIC BLOCK: order_row -->
        <tr >
          <td align="right" colspan="3">Итого:&nbsp;</td>
          <td nowrap>&nbsp;<b>{total_sum}</td>
        </tr>	  
		<tbody>		
	</table>
			<div>
			<label class="checkbox" for="agree">
				<input type="checkbox" id="agree" name="agree"> C <a href="{_SITE_}/rightdeliv.html" class="drop-links">условиями</a> доставки согласен! Читайте внимательно!
			</label>
			</div>
			
			<div class="pull-right">
			<a href="#" class="drop-links" style="font-size: 16px;" onclick="showAdress();">Указать адрес доставки. Это можно сделать позже.</a>
			</div>			
			<br><br>
			<a href="{_SITE_}/basket.html" role="button" class="btn btn-large btn-primary" ><i class="icon-arrow-left icon-white"></i> Вернуться к корзине </a>
			<button class="btn btn-large btn-primary pull-right" onclick="yaCounter39186095.reachGoal ('oformlenie zakaza');" type="submit">Оформить заказ&nbsp;&nbsp;&nbsp; <i class="icon-arrow-right icon-white"></i> </button>	 
	</form>	  
	<br><br><br>

</div>
</div>

<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.js"></script> 
<script type="text/javascript">

	$("#sendform").validate({
		rules: {
			agree: "required"
		},
		messages: {
			agree: '<span class="label label-important">Для регистрации необходимо согласится с условиями</span>'
		}
	});
	function showAdress()  { 
		$('#modalAdress').modal();
	}

</script>

<div class="modal hide fade" id="modalAdress" >
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h3>Адрес доставки</h3>
  </div>
  <div class="modal-body">
		<form class="form-vertical" id="adressform" action="{_SITE_}/preorder.html" method="post">
		  <input type="hidden" name="adress" value="save">
		  <fieldset>
		  <div class="row-fluid">
			<div class="control-group">
			  <label class="control-label" for="d_name">Ф.И.О. получателя</label>
			  <div class="controls">
				<input type="text" class="span12" id="d_name" name="d_name" value="{d_name}">
			  </div>
			</div>
			<div class="control-group">
			  <label class="control-label" for="d_pasport">Паспорт (серия и номер), необходимы для получения посылки</label>
			  <div class="controls">
				<input type="text" class="span6" id="d_pasport" name="d_pasport" value="{d_pasport}">
			  </div>
			</div>			
			<div class="control-group">
			  <label class="control-label" for="d_zip">Индекс</label>
			  <div class="controls">
				<input type="text" class="span3" id="d_zip" name="d_zip" value="{d_zip}">
			  </div>
			</div>
			<div class="control-group">
			  <label class="control-label" for="d_adress">Адрес</label>
			  <div class="controls">
				<input type="text" class="span12" id="d_adress" name="d_adress" value="{d_adress}">
			  </div>
			</div>
		</div>		
		  </fieldset>
		
  </div>
  <div class="modal-footer">
	<button class="btn" data-dismiss="modal" aria-hidden="true">Закрыть</button> 
	<button class="btn btn-primary " type="submit">Сохранить адрес</button>
  </div>
  </form>
</div>	

<script type="text/javascript">
	
	$("#adressform").validate({
		rules: {
			d_name: "required",
			d_zip: "required",
			d_adress: "required"
		},
		messages: {
			d_name: '<span class="label label-important">Необходимо заполнить Ф.И.О. получателя</span>',
			d_zip: '<span class="label label-important">Необходимо указать индекс</span>',
			d_adress: '<span class="label label-important">Необходимо указать адрес доставки</span>'
		}
	});	

</script>