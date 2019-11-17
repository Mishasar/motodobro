<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>
<ul class="nav-pills">
  <li >
    <a href="{_SITE_}/orders.html"><i class="icon-shopping-cart"></i> Список заказов</a>
  </li>
  <li class="active"><a href="#"><i class="icon-edit"></i> Переписка</a></li>
  <li><a href="{_SITE_}/exit.html"><i class="icon-off"></i> Выход из кабинета</a></li>
</ul>	
	<h3 align="center" style="margin-top:20px;">{h1}</h3>
	<a data-toggle="modal" href="#myModal" class="btn btn-primary btn-large">Задать вопрос</a>
	
	<table class="table table-hover" style="margin-top:20px;">
		<caption></caption>
		<thead>
            <tr>
                <th width="120">Дата вопроса</th>
                <th width="150">Ответ</th>
                <th>Вопрос</th>
            </tr>
		</thead>
		<tbody>						
		<!-- BEGIN DYNAMIC BLOCK: order_row -->
		  <tr class="rec_msg" id="{msg_id}" style="cursor:pointer;">
			<td nowrap>{m_date}</td>
			<td nowrap>{status}</td>
			<td >{msg}</td>
		  </tr>
		<!-- END DYNAMIC BLOCK: order_row -->
		{no_msg}	
		<tbody>		
	</table>	
	<a data-toggle="modal" href="#myModal" class="btn btn-primary btn-large">Задать вопрос</a>
	</div>	 
</div>	

<form class="form-horizontal" action="{_SITE_}/corresp.html" method="post"> 
<div class="modal hide fade" id="myModal">
  <div class="modal-header">
    <a class="close" data-dismiss="modal">×</a>
    <h3>Задайте свой вопрос</h3>
  </div>
  <div class="modal-body"> 
	<textarea style="width:516px; height:100px;" name="question" placeholder="Введите ваш вопрос и нажмите кнопку &quot;Отправить вопрос&quot;"></textarea>
  </div>
  <div class="modal-footer">
	<button class="btn" data-dismiss="modal" aria-hidden="true" style="height:30px;">Закрыть</button> 
	<button class="btn btn-primary" style="height:30px;" type="submit" name="add_msg">Отправить вопрос</button>	
  </div> 
</div>
</form>	

<script>

$(".rec_msg").click(function()
{
    document.location.href = '{_SITE_}/msg_'+ $(this).attr('id') +'.html';
}); 

</script>