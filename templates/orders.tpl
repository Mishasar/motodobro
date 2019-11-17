<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>
<ul class="nav-pills">
  <li class="active">
    <a href="#"><i class="icon-shopping-cart"></i> Список заказов</a>
  </li>
  <li><a href="{_SITE_}/corresp.html"><i class="icon-edit"></i> Переписка</a></li>
  <li><a href="{_SITE_}/exit.html"><i class="icon-off"></i> Выход из кабинета</a></li>
</ul>	
	<h3 align="center" style="margin-top:20px;">{h1}</h3>
	<div class="alert alert-block"><p>Ниже приведен список Ваших заказов. Для того чтоб посмотреть подробности заказа или распечатать квитанцию для оплаты - нажмите на номер интересующего вас заказа.</p></div> 
	<table class="table table-bordered table-hover">
		<caption></caption>
		<thead>
            <tr>
                <th width="150">№ Заказа</th>
                <th>Статус заказа</th>
                <th width="150">Статус оплаты</th>
                <th>Статус отгрузки</th>
                <th>Сумма</th>				
                <th>Оплачено</th>
				<th>Отгружено</th>	
            </tr>
		</thead>
		<tbody>						
		<!-- BEGIN DYNAMIC BLOCK: order_row -->
		  <tr>
			<td nowrap><a href="{_SITE_}/order_{id}.html">№{num} от {s_date}</a><br><div class="pull-right"><a href="{_SITE_}/order_{id}.html" class="btn btn-small btn-info">Открыть заказ</a></div></td>
			<td >{s2}</td>
			<td nowrap>{s1} {s1k}</td>
			<td >{s3}</td>
			<td ><b>{zak}</td>
			<td ><b>{opl}</td>
			<td ><b>{otg}</td>
		  </tr>
		<!-- END DYNAMIC BLOCK: order_row -->
		  <tr class="success">
			<td colspan="4" ><div class="pull-right">ИТОГО:&nbsp;</div></td>
			<td ><b>{total_zak}</td>
			<td ><b>{total_opl}</td>
			<td ><b>{total_otg}</td>
		  </tr>		
		<tbody>		
	</table>	

	</div>	 
</div>	