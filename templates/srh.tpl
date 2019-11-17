<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>
	<h3 align="center" >{h1}</h3>
	{tlt_srh}
	<table class="table table-condensed table-hover">
      <!-- BEGIN DYNAMIC BLOCK: tlt_srh_row -->	
		<thead>
            <tr>
                <th>Код</th>
                <th>Описание</th>
                <th>Цена</th>
                <th>В корзину</th>			
            </tr>
		</thead>
      <!-- END DYNAMIC BLOCK: tlt_srh_row -->		
		<tbody>						
      <!-- BEGIN DYNAMIC BLOCK: srh_row -->
        <tr>
          <td >{code}</td>
          <td >{descr}</td>
          <td >{price}</td>
          <td >{add_to_basket}</td>
        </tr>
      <!-- END DYNAMIC BLOCK: srh_row -->	
		<tbody>		
	</table>

{new_tlt_srh_count}	

      <table  class="table table-condensed table-hover">
      <!-- BEGIN DYNAMIC BLOCK: row_new_oem_cat -->
        <tr>
          <td>{new_oem_catalog}</td>
        </tr>
      <!-- END DYNAMIC BLOCK: row_new_oem_cat -->
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
			data: "", cache: false, type: 'GET', async: true,
			success: function(html) {			
				$("#bas_content").html(html);			
			}
		} );	
		
		$('#modal').modal();
	}
</script>

<div class="modal hide fade" id="modal" >
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4>Товар добавлен в корзину</h4>
  </div>
  <div class="modal-body">
    <p><img src="{_SITE_}/img/shoppingcart_full.png" align="left" height="48" width="48" border="0">Товар добавлен в Вашу корзину.<br>Далее Вы можете <a href="{_SITE_}/basket.html">перейти в корзину</a> для оформления заказа или закрыть это окно и продолжить покупки. </p>
  </div>
  <div class="modal-footer">
	<a href="{_SITE_}/basket.html" class="btn btn-info"><i class="icon-shopping-cart icon-white"></i> Перейти в корзину</a>
	<button class="btn" data-dismiss="modal" aria-hidden="true">Закрыть и продолжить</button>  
  </div>
</div>