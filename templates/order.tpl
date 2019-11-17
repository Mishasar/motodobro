<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>
	<h3 align="center" >{h1}</h3>
	<!-- BEGIN DYNAMIC BLOCK: no_pay -->
	<div class="row-fluid">		
		<div class="span12">
			 <div class="alert alert-block"><p>Заказ поступит в обработку  после поступления денег на наш счет.</p> 
		  
			<form action="{_SITE_}/orderpay_.html" method="post" style="padding:0px; margin:10px;" target="_blank">
			 <input type="submit" name="update" value="&nbsp;&nbsp;ОПЛАТИТЬ ЗАКАЗ&nbsp;&nbsp;" class="btn btn-inverse">
			 <input name="pay" value="{pay_id}" type="hidden">
			</form>	
			</div> 
		</div>		
	</div>
	<!-- END DYNAMIC BLOCK: no_pay -->
	<div class="row-fluid">	
		<div class="span12">		
			<table class="table table-bordered table-condensed table-hover">
				<thead>
					<tr>
						<th>Код детали</th>
						<th>Описание</th>
						<th>Цена</th>
						<th>Кол-во</th>
						<th>Сумма</th>
						<th>Состояние</th>								
					</tr>
				</thead>
				<tbody>						
				<!-- BEGIN DYNAMIC BLOCK: order_row -->
				  <tr>
					<td ><b>{code}</td>
					<td >{descr}</td>
					<td ><b>{price}</td>
					<td ><b>{qty}</td>
					<td ><b>{sum}</td>
					<td >{status}</td>
				  </tr>
				<!-- END DYNAMIC BLOCK: order_row -->
				  <tr class="success">
					<td colspan="3" >&nbsp;</td>
					<td ><b>{total_qty}</td>
					<td ><b>{total_sum}</td>
					<td >&nbsp;</td>
				  </tr>		
				<tbody>		
			</table>
		</div>	
	</div>	
	<div class="row-fluid">		
	  <div class="span6">
		 Комментарий менеджера:<br>
		 <textarea rows=6 name="msg" class="span12">{note}</textarea>
	  </div>
	  <div class="span6">
		<table class="table table-bordered table-condensed">
			<caption><b>Платежи по заказу:</b></caption>
			<tbody>						
			  <!-- BEGIN DYNAMIC BLOCK: trn_row -->
			  <tr>
				  <td >{pay_trn}</td>
				  <td ><b>{pay_sum}</b></td>
			  </tr>
			  <!-- END DYNAMIC BLOCK: trn_row -->
			  <tr>
				<td >ИТОГО:</td>
				<td ><b>{total_pay_sum}</b></td>
			  </tr>	
			<tbody>		
		</table>

		<table class="table table-bordered table-condensed">
			<caption><b>Отгрузки по заказу:</b></caption>
			<tbody>						
			  <!-- BEGIN DYNAMIC BLOCK: ship_row -->
			  <tr>
				  <td >{ship_trn}</td>
				  <td ><b>{ship_sum}</b></td>
			  </tr>
			  <tr>
				  <td colspan="2"><b>{deliv}</b></td>
			  </tr>		  
			  <!-- END DYNAMIC BLOCK: ship_row -->
			  <tr>
				<td >ИТОГО:</td>
				<td ><b>{total_ship_sum}</b></td>
			  </tr>	
			<tbody>		
		</table>	
		 
	  </div>
	</div>	
	

	
</div>	
</div>	
<script type="text/javascript">	
function showModal(id)  { 
		$.ajax({
		  url: "{_SITE_}/files/trace.php",
		  data: "id="+id,
		  cache: false,
		  success: function(html){
			$("#infoProd").html(html);
		  }
		});	
		
	$('#modalOrder').modal();
	return false;
}
</script>

<div class="modal hide fade" id="modalOrder" >
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4>Информация о товаре</h4>
  </div>
  <div class="modal-body" id="infoProd">
    <p> </p>
  </div>
  <div class="modal-footer">
	<button class="btn" data-dismiss="modal" aria-hidden="true">Закрыть</button>  
  </div>
</div>	
