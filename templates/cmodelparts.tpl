<div class="content">
    <div class="wrapper">
        <ul class="breadcrumb">
            {navigate}
        </ul>
        {hidden_navigation}
        {hidden_brand}
            {harlye_widget}
            <h3 align="center" itemscope itemtype="http://schema.org/Product">
                {schemaProp2}
                <br>
                {schemaProp1}
            </h3>   
        <div style="text-align: center; margin-bottom: 20px;">{unitLink}</div>
        <table class="desctop" border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
            <tr>
                <td width="540" align="left" valign="top">
                    <div id="sticky" class="sticky-element">
                        <div class="sticky-content">		
                            <div class="pp-image" id="pp-image">
                                <a href='{img_big}' class = 'cloud-zoom' rel="position: 'inside' , showTitle: false, adjustX:3, adjustY:-1">				   
                                    <img src="{img_big}" title="Увеличенное изображение" alt='' width="520" class="img-polaroid"/>
                                </a>
                            </div>
                        </div>
                    </div>					
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
                        </tbody>		
                    </table>
                </td>
            </tr>
        </table>                
        <ul class="nav nav-tabs tab-parts phone">
            <li><a href="#diagram" data-toggle="tab">Диаграмма</a></li>
            <li class="active"><a href="#details" data-toggle="tab">Список деталей</a></li>
        </ul>
        <div class="tab-content phone">
            <div class="tab-pane fade" id="diagram">
                <div id="sticky" class="sticky-element">
                    <div class="sticky-content">
                        <div class="pp-image" id="pp-image">
                            <a href='{img_big}' class = 'cloud-zoom' rel="position: 'inside' , showTitle: false, adjustX:3, adjustY:-1">				   
                                <img src="{img_big}" title="Увеличенное изображение" alt='' width="520" class="img-polaroid"/>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade active in" id="details">
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
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="pp-footer"></div>
        <hr>
        <h3 >Другие {h3}</h3>
        <!--<table class="table table-striped">
            {/*list_unit*/}
        </table>-->
            <div class="model-units">
            {units}
        </div>
    </div>	
</div>	

<script type="text/javascript">
 $(document).ready(function(){
        window.onscroll = function(){
            handleTabParts();
        };
        
        window.isSetLastElementOffset = false;
        window.lastElementOffset = 0;

        function handleTabParts(){
            var element = $(".tab-parts"),
                scrollTop = $(window).scrollTop(),
                elementOffset = element.offset().top,
                distance = (elementOffset - scrollTop);

            if(distance <= 0 && !window.isSetLastElementOffset){ 
                window.isSetLastElementOffset = true;
                window.lastElementOffset = elementOffset;
                element.addClass('tab-fixed-top').css('top', 0);
            }
            else if(scrollTop <= window.lastElementOffset && window.isSetLastElementOffset){
                window.isSetLastElementOffset = false;
                element.css('top', window.lastElementOffset + 'px').removeClass('tab-fixed-top');
            }
        }
    });
    
(function(){    
    
    var a = document.querySelector('#pp-image'), b = null, P = 10;  // если ноль заменить на число, то блок будет прилипать до того, как верхний край окна браузера дойдёт до верхнего края элемента. Может быть отрицательным числом
    window.addEventListener('scroll', Ascroll, false);
    document.body.addEventListener('scroll', Ascroll, false);           
    
    function Ascroll() {
            //if( $(window).width() >= 992 ) {
                    if (b == null) {
                            var Sa = getComputedStyle(a, ''), s = '';
                            for (var i = 0; i < Sa.length; i++) {
                                    if (Sa[i].indexOf('overflow') == 0 || Sa[i].indexOf('padding') == 0 || Sa[i].indexOf('border') == 0 || Sa[i].indexOf('outline') == 0 || Sa[i].indexOf('box-shadow') == 0 || Sa[i].indexOf('background') == 0) {
                                            s += Sa[i] + ': ' +Sa.getPropertyValue(Sa[i]) + '; '
                                    }
                            }
                            b = document.createElement('div');
                            b.style.cssText = s + ' box-sizing: border-box; width: ' + a.offsetWidth + 'px;';
                            a.insertBefore(b, a.firstChild);
                            var l = a.childNodes.length;
                            for (var i = 1; i < l; i++) {
                                    b.appendChild(a.childNodes[1]);
                            }
                            a.style.height = b.getBoundingClientRect().height + 'px';
                            a.style.padding = '0';
                            a.style.border = '0';
                    }

                    var Ra = a.getBoundingClientRect(),
                    R = Math.round(Ra.top + b.getBoundingClientRect().height - document.querySelector('#pp-footer').getBoundingClientRect().top + 0);  // селектор блока, при достижении верхнего края которого нужно открепить прилипающий элемент;  Math.round() только для IE; если ноль заменить на число, то блок будет прилипать до того, как нижний край элемента дойдёт до футера
                    if ((Ra.top - P) <= 0) {
                            if ((Ra.top - P) <= R) {
                                    b.className = 'stop';
                                    b.style.top = - R +'px';
                            } else {
                                    b.className = 'sticky';
                                    b.style.top = P + 'px';
                            }
                    } else {
                            b.className = '';
                            b.style.top = '';
                    }
                    window.addEventListener('resize', function() {
                            a.children[0].style.width = getComputedStyle(a, '').width
                    }, false);
            //}
    }
    })();


    function addProduct(form) {
        var $form = $(form)
        var products = [
            {
                "id": $form.find('[name="id"]').val(),
                "name": $form.find('[name="descr"]').val(),
                "price": $form.find('[name="price_rub"]').val(),
                "brand": $('[name="hidden_brand"]').val(),
                "category": $('[name="hidden_navigation"]').val(),
                "quantity": 1
            }
        ];

        var options = {
            success: showModal	
        };

        $(form).submit(function() { 
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
        $.post('/ajax/basket.php?get_users_products')
        .done(function(data){
            $('.basket-badge').html(data.count);
        });
        
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



