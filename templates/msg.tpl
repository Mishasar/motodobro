<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>
	
	<h3 align="center" style="margin-top:20px;">{h1}</h3>
	
	<table class="table table-hover table-striped" style="margin-top:20px;">
		<caption></caption>
		<tbody>						
		<!-- BEGIN DYNAMIC BLOCK: order_row -->
		  <tr >
			<td ><div>{writer}<span class="pull-right">{m_date}</span></div><div>{msg}</div></td>
		  </tr>
		<!-- END DYNAMIC BLOCK: order_row -->	
		<tbody>		
	</table>
<div class="row">
  <div class="span6">
	<form class="form-horizontal" action="{_SITE_}/msg_{msg_id}.html" method="post"> 
		<label>Отправить новое сообщение</label>
		<textarea class="span6" name="question" placeholder="Введите текст сообщения" style="height:100px;"></textarea>
		<button class="btn btn-primary" style="height:30px;margin-top:10px;" type="submit" name="add_msg">Отправить вопрос</button>	
	</form>		
	</div>
</div>	
	</div>	 
</div>	
