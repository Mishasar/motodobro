<div class="content">
    <div class="wrapper" itemscope itemtype="http://schema.org/Product">
        <ul class="breadcrumb">
            {navigate}
        </ul>
        <h2 style="margin:0px; margin-left:30px; text-align: left;" itemprop="name">{h3}</h2>
        <h3 style="margin:0px; margin-left:30px; margin-bottom:20px; text-align: left;"  >{h1}</h3>

        <div class="phone" style="padding: 10px;">
            <div style="border: 1px solid #ccc; padding: 10px; min-height: 100px; background-color: white;">
                <img src="{img_brand}" title="{h1}" alt="" style="margin-top:5px;height:40px;display: block;">	
                <div class="pull-right" style="padding-top:10px; padding-right:10px; text-align:right; font: 14px 'segoe_ui_light',sans-serif;font-weight:bold;">
                        ЗАПЧАСТИ ДЛЯ МОТОТЕХНИКИ<br>
                        www.motodobro.ru
                </div>
            </div>
                <div>
                    <table class="table table-striped">
                                <tbody>						
                                        {list_model}
                                <tbody>		
                        </table>
                </div>
        </div>
        <table class="desctop" border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
            <tr>
                <td width="450" valign="top" style="padding:12px;">	
                    <table border="0" width="100%" cellspacing="0" cellpadding="0" style="border: 1px solid #ccc; ">
                        <tr>
                            <td width="150" valign="top" style="padding:5px;padding-bottom:20px;">
                                <img src="{img_qr}" title="{h3}, {h1} " alt='' class="img-polaroid"/>	
                            </td>
                            <td valign="top" style="padding:10px;padding-left:0px;">
                                <h3 style="margin:0px; text-align: left; color:#000; font-weight:bold;">{card_code}</h3>
                            </td>
                        </tr>
                        <tr>
                            <td height="60" colspan="2" style="border-top: 1px solid #ccc;border-bottom: 1px solid #ccc;background-color:#fff;">
                                <img src="{img_brand}" title="{h1}" alt="" style="margin-top:5px;height:40px;">	
                                <div class="pull-right" style="padding-top:10px; padding-right:10px; text-align:right; font: 14px 'segoe_ui_light',sans-serif;font-weight:bold;">
                                    ЗАПЧАСТИ ДЛЯ МОТОТЕХНИКИ<br>
                                    www.motodobro.ru
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top" style="padding:10px;padding-top:0px;">	
                    <table class="table table-striped">
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
        <div class="alert alert-black" style="margin-bottom:2px;">Внимание! При проценке стоимости деталей система показывает стоимость без учета доставки до склада в РФ<br>Доставка расчитывается по фактическому весу. Переместите деталь в корзину, чтобы увидеть расчет.</div><br><br>
        {new_tlt_srh_count}	
        <div style="display: none;" >
            <img itemprop="logo" src="http://www.motodobro.ru/img/logo_new.png">
        </div>
        <div style="display: none;" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
            <span itemprop="price">{dis_price}</span>
            <span itemprop="priceCurrency" content="RUB">р</span>
            <span itemprop="availability" >{nalich}</span>
            <div itemprop="deliveryLeadTime" itemscope itemtype="http://schema.org/QuantitativeValue">
                <span itemprop="minValue">17</span> -
                <span itemprop="maxValue">32</span> <span> дней. Доставка на заказ из США</span>                
                <meta itemprop="unitCode" content="E49" />
            </div>
        </div>
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
        success : showModal	
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
            ga('send','event', 'AddToCart', 'add');
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



