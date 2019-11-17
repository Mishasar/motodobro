<div class="content">
    <div class="wrapper">
        <ul class="breadcrumb">
            {navigate}
        </ul>
        <h3>Ваш заказ</h3>
        <form action="{_SITE_}/orderpaynoreg.html" method="post" style="padding:0px; margin:0px;" id="sendform">
            <input type="hidden" name="order" value="ok">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th></th>
                    <th>Код детали</th>
                    <th>Описание</th>
                    <th>Кол-во</th>
                    <th>Сумма, руб.</th>
                    <th>Срок доставки</th>
                </tr>
                </thead>
                <tbody>
                <!-- BEGIN DYNAMIC BLOCK: order_row -->
                <tr>
                    <td>
                        {del_link}
                    </td>
                    <td nowrap><b>{code}</b></td>
                    <td>{descr}</td>
                    <td nowrap>
                        <div class="input-prepend input-append">
                            {qty}
                        </div>
                    </td>
                    <td nowrap>{sum}</td>
                    <td nowrap>{delivery}</td>
                </tr>
                <!-- END DYNAMIC BLOCK: order_row -->
                <tr>
                    <td align="right" colspan="5">Итого:&nbsp;</td>
                    <td nowrap>&nbsp;<b>{total_sum} руб.</td>
                </tr>
                <tbody>
            </table>

            <div class="well">
                <p>ДОПОЛНИТЕЛЬНО к указанной цене оплачивается доставка из США в РФ из расчёта 1000 рублей за
                    1 кг веса детали (если вес запчасти 300 грамм, то добавляется только 300 руб)</p>
                <div>
                    <label class="checkbox" for="agree">
                        <input type="checkbox" id="agree" name="agree">
                        Прочитал и оплачу доставку по факту
                    </label>
                </div>
            </div>

            <h3>Укажите способ и адресс доставки</h3>
            <label class="radio">
                <input type="radio" name="delivery" value="1" class="js-delivery" data-type="type1" checked>
                СДЕК удобная и дешёвая курьерская служба.
            </label>
            <label class="radio">
                <input type="radio" name="delivery" value="2" class="js-delivery" data-type="type2">
                Почта России. Удобная только для небольших посёлков.
            </label>
            <label class="radio">
                <input type="radio" name="delivery" value="3" class="js-delivery" data-type="type3">
                ТК Деловые Линии. Подходит для объёмных тяжёлых деталей.
            </label>
            <label class="radio">
                <input type="radio" name="delivery" value="4" class="js-delivery" data-type="type4">
                EMS. Дальний Восток, Камчатка.
            </label>

            <!-- BEGIN DYNAMIC BLOCK: bool_reg -->
            <h3>Получатель и контакты</h3>
            <div class="row-fluid">
                <a class="btn pull-right" href="#modalAuth" role="button" data-toggle="modal">
                    <i class="icon-user icon-white"></i>Войти и не заполнять адрес</a>
            </div>
            <div class="row-fluid">
                <div class="span4">
                    <label class="control-label" for="USER_NAME">ФИО</label>
                    <div class="controls">
                        <input type="text" name="USER_NAME" id="USER_NAME" class="input-block-level" required>
                    </div>
                </div>
                <div class="span4">
                    <label class="control-label" for="USER_PHONE">Телефон</label>
                    <div class="controls">
                        <input type="text" name="USER_PHONE" id="USER_PHONE" class="input-block-level input-mask-phone"
                               required>
                    </div>
                </div>
                <div class="span4">
                    <label class="control-label" for="EMAIL">EMAIL</label>
                    <div class="controls">
                        <input type="email" id="EMAIL" name="USER_EMAIL" class="input-block-level" required>
                    </div>
                </div>
            </div>
            <!-- END DYNAMIC BLOCK: bool_reg -->
            <div class="row-fluid delivery-fields js-delivery-fields">
                <div class="delivery-field control-group js-delivery-field" data-type1 data-type2 data-type3 data-type4>
                    <label class="control-label" for="d_city">Населённый пункт</label>
                    <div class="controls">
                        <input type="text" class="span12" id="d_city" name="d_city" value="{d_city}">
                    </div>
                </div>
                <div class="delivery-field control-group js-delivery-field" data-type3>
                    <label class="control-label" for="d_pasport">Паспорт (серия и номер)</label>
                    <div class="controls">
                        <input type="text" class="span12" id="d_pasport" name="d_pasport" value="{d_pasport}">
                    </div>
                </div>
                <div class="delivery-field control-group js-delivery-field" data-type2 data-type4>
                    <label class="control-label" for="d_zip">Индекс</label>
                    <div class="controls">
                        <input type="text" class="span12" id="d_zip" name="d_zip" value="{d_zip}">
                    </div>
                </div>
                <div class="delivery-field delivery-field_wide control-group js-delivery-field" data-type1 data-type2
                     data-type4>
                    <label class="control-label" for="d_adress">Адрес</label>
                    <div class="controls">
                        <input type="text" class="span12" id="d_adress" name="d_adress" value="{d_adress}">
                    </div>
                </div>
            </div>
            <br><br>
            <a href="{_SITE_}/basket.html" role="button" class="btn btn-large btn-primary"><i
                        class="icon-arrow-left icon-white"></i> Вернуться к корзине </a>
            <button class="btn btn-large btn-primary pull-right"
                    onclick="yaCounter39186095.reachGoal ('oformlenie zakaza');" type="submit">Оформить заказ&nbsp;&nbsp;&nbsp;
                <i class="icon-arrow-right icon-white"></i></button>
        </form>
        <br><br><br>

    </div>
</div>

<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.js"></script>
<script type="text/javascript">
    var $deliveryLinks = $('.js-delivery');
    showDeliveryFields($deliveryLinks.first().data('type'));

    $deliveryLinks.on('click', function (e) {
        var $el = $(e.target);
        showDeliveryFields($el.data('type'));
    });

    $("#sendform").validate({
        rules: {
            agree: "required"
        },
        messages: {
            agree: '<span class="label label-important">Для продолжения оформлени необходимо согласится с условиями</span>'
        }
    });

    function showAdress() {
        $('#modalAdress').modal();
    }

    function showDeliveryFields(type) {
        var $fields = $('.js-delivery-field');
        var height = $fields.outerHeight();
        $fields.css('height', height);
        var $visibleFields = $fields.filter('[data-' + type + ']');
        $fields.filter(':not([data-' + type + '])').hide().find('input').prop('required', false);
        $fields.filter('[data-' + type + ']').show().find('input').prop('required', true);
    }

    $('.js-basket-qty').on('change', function (e) {
        $el = $(e.target);
        document.location.href = "/basket.html?product_id=" + $el.data('id') + "&qty=" + $el.val();
    });
</script>

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

<style>
    .delivery-fields .span4:nth-child(3n + 1) {
        margin-left: 0;
    }

    .delivery-fields {
        display: flex;
        align-items: flex-end;
        flex-wrap: wrap;
        max-height: 500px;
        transition: height .5s ease;
    }

    .delivery-field {
        flex: 1 1 0;
    }

    .delivery-field + .delivery-field {
        margin-left: 10px;
    }

    .delivery-field_wide {
        flex: 2 1 0;
    }

    .controls label.error {
        display: none !important;
    }

    .basket-quantity::-webkit-inner-spin-button,
    .basket-quantity::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }


</style>