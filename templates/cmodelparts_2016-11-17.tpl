<div class="content">
	<div class="wrapper">
		<ul class="breadcrumb">
			{navigate}
		</ul>
		<h3 align="center" >{h3}<br>{h1}</h3>
	


		<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
		  <tr>
			<td width="540" align="left" valign="top">
			  <a href='{img_big}' class = 'cloud-zoom' rel="position: 'inside' , showTitle: false, adjustX:3, adjustY:-1">
				   
					<img src="{img_big}" title="Увеличенное изображение" alt='' width="520" class="img-polaroid"/></a>		
			</td>
			<td valign="top" >	
		<table class="table table-striped table-hover table-condensed">
			<thead>
				<tr>
					<th nowrap width="20" style="text-align:center;vertical-align:middle;font-size:12px;">№</th>
					<th style="text-align:center;vertical-align:middle;font-size:12px;">Деталь</th>
					<th nowrap width="30">В узле</th>
					<th nowrap width="60" style="text-align:center;vertical-align:middle;font-size:12px;" colspan="2">Цена</th>
				</tr>
			</thead>
			<tbody>						
				{list_model}
			<tbody>		
		</table>
			<!--
			<div class="alert alert-black">	
				Каталог несет в первую очередь справочную информацию, поэтому обращаем ваше  внимание,  что наличие деталей в каталоге не означает ее наличие на нашем складе.<br>
				Все  детали поставляются только под заказ. Срок исполнения заказа 12-15 рабочих дней.
			</div>		
			-->
			</td>
		  </tr>
		</table> 

	
	<hr>
	<h3 >Другие {h3}</h3>
	<table class="table table-striped">
	{list_unit}
	</table>				   
	</div>	
</div>	


<script type="text/javascript">
	
	function addProduct(form) {
		var options = {
        success:       showModal	
		};	
    $(form).submit(function() { 
        $(this).ajaxSubmit(options);  
        return false; 
    }); 	
	}
  
	function showModal()  { 
		$.ajax({
		  url: "{_SITE_}/files/basket_query.php",
		  cache: false,
		  success: function(html){
			$("#bas_content").html(html);
		  }
		});	
		$('#modal').modal();
	}
</script>

<div class="modal hide fade" id="modal" >
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4>Товар добавлен в корзину</h4>
  </div>
  <div class="modal-body">
    <p>Товар добавлен в Вашу корзину.<br>Далее Вы можете <a href="{_SITE_}/basket.html">перейти в корзину</a> для оформления заказа или закрыть это окно и продолжить покупки. </p>
  </div>
  <div class="modal-footer">
	<button class="btn" data-dismiss="modal" aria-hidden="true">Закрыть</button>  
  </div>
</div>	



