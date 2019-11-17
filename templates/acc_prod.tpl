<div class="content">
	<div class="wrapper">
		<ul class="breadcrumb">
			{navigate}
		</ul>
        {hidden_navigation}
        {hidden_brand}
	
		<div class="row-fluid" >
			<div class="span3" >
				<img src="{_SITE_}/img/acc_covers/{big_img}" border="0" hspace="0" vspace="0" style="padding-top:10px; width:100%;"><br><br>
				<ul class="nav-list">
				  <li class="nav-header">
					Оглавление
				  </li>
				  <!-- BEGIN DYNAMIC BLOCK: row_menu -->
				  <li class="{CL}">{NAME}</li>
				  <!-- END DYNAMIC BLOCK: row_menu -->	
				</ul>			
			</div>
			<div class="span9" style="background-color: #ffffff;padding-top:20px;padding-bottom:20px;margin-top:-16px;">
				<h3>{h1}<br><small>{h2}</small></h3>
					<div class="row-fluid">
						<div class="span12" style="padding:10px;padding-top:0px;">
							<span style="font-size:12px;">{features}</span>								
						</div>
					</div>				

					<div class="row-fluid">
						<div class="span12" style="padding:10px;text-align:center;">
													
							<center>{group_img}</center>
							<center>{diogramm}</center>
							<center>
							<ul class="thumbnails" style="margin-top:4px;">
							<!-- BEGIN DYNAMIC BLOCK: adv_img_block -->
								<li class="span2">
									<div class="thumbnail">
										<a href="javascript:void(0);" title="{adv_descr}" onclick="javascript:document.images.big.src='{adv_img}';">
											<img src={adv_img} alt="{adv_descr}">
										</a>
									</div>
								</li>
							<!-- END DYNAMIC BLOCK: adv_img_block -->
							</ul>							
							</center>
						</div>						
					
					</div>
					<div class="row-fluid">
						<div class="span12" style="padding:4px;padding-top:0px;">
							<table class="table table-striped table-hover">
								<thead>
									<tr>
										<th nowrap style="text-align:center;vertical-align:middle;font-size:12px;">Деталь</th>
										<th nowrap  width="80" style="text-align:center;vertical-align:middle;font-size:12px;">Цена</th>
										<th nowrap  width="100" style="text-align:center;vertical-align:middle;font-size:12px;">В корзину</th>
									</tr>
								</thead>
								<tbody>						
									{list_model}
								<tbody>		
							</table>							
						</div>
					</div>
			</div>	
		</div>

	</div>	
</div>	
<script language="javascript" type="text/javascript">
	function zoom(path,w,h,nm){
		zoomWnd=window.open('', 'newWin', 'width='+w+','+'height='+h+',titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no');
		zoomWnd.document.write('<HTML> <HEAD><TITLE>'+nm+'<\/TITLE><\/HEAD><BODY leftmargin=0 topmargin=0 marginwidth=0 marginheight=0><CENTER>');
		zoomWnd.document.write('<A HREF="" onclick="window.close()"><IMG SRC="'+path+'" WIDTH="'+w+'" HEIGHT="'+h+'" ALT="изображение '+path+'" TITLE="нажмите чтобы закрыть" border="0"><\/A>');
		zoomWnd.document.write('</CENTER><\/BODY> <\/HTML>')
	}


    function addProduct(form) {
        var $form = $(form)
        var products = [
            {
                "id": $form.find('[name="id"]').val(),
                "name": $form.find('[name="descr"]').val(),
                "price": $form.find('[name="price"]').val(),
                "brand": $('[name="hidden_brand"]').val(),
                "category": $('[name="hidden_navigation"]').val(),
                "quantity": $form.find('[name="qty"]').val()
            }
        ];

        var options = {
            success: showModal
        };

        $(form).submit(function () {
            $(this).ajaxSubmit(options);

            dataLayer.push({
                "ecommerce": {
                    "currencyCode": "RUB",
                    "add": {
                        "products":products
                    }
                }
            });
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