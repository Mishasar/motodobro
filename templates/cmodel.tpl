<div class="content">
	<div class="wrapper">
	<ul class="breadcrumb">
		{navigate}
	</ul>

		{harlye_widget}

	  <div class="span10" style="padding-top:20px;"><h3>{h3} {h1}<br><small>Выбор модели {brand_name}</small></h3></div>


	
     <table class="table table-bordered">
			 <div id = "list_model">
	  	 	{list_model}
			</div>
     </table>
	</div>
</div>

<script>
$('.model_name').change(function () {
    var name = $(this).find(':selected')[0].value;
		var id = $(this).id;
    $.ajax({
        type: 'POST',
        url: '/includes/model.php',
        data: {
            'name': name,
						'year_id': id
        },
        success: function (data) {
					$('#list_model').html(data);
    });
});
</script>
