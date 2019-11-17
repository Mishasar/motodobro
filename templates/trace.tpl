<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="/css/bootstrap.css" rel="stylesheet">
</head>

<body >

<br>
<table class="table table-condensed">
  <caption>Движение позиции <b>{d_code}</b> ({d_descr}) - {d_qty} шт.</caption>
		<thead>
            <tr>
				<th>Операция</th>
				<th>Кол-во</th>
				<th>&nbsp;</th>
            </tr>
		</thead>
		<tbody>	
		<!-- BEGIN DYNAMIC BLOCK: order_row -->
		  <tr >
			<td >{trans}</td>
			<td ><b>{qty}</td>
			<td >&nbsp;</td>
		  </tr>
		<!-- END DYNAMIC BLOCK: order_row -->
		</tbody>		
</table>

</body>
</html>