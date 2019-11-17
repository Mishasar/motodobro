<div class="content">
	<div class="wrapper">
		<ul class="breadcrumb">
			{navigate}
		</ul>
	
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
				<h3>{cat_name}<br><small>Неоригинальные запчасти и аксессуары</small></h3>
					<ul class="nav-list">
						 <!-- BEGIN DYNAMIC BLOCK: index_row_cat -->
						   <li class="{INDEX_CL}">{INDEX_NAME}</li>
						 <!-- END DYNAMIC BLOCK: index_row_cat -->
					</ul>	
			</div>	
		</div>

	</div>	
</div>	


<script type="text/javascript">
    function setImgThumbSize(objName)
    {
            var obj = objName;
            if (obj.height> obj.width) {
               var x_ratio = 100 / obj.height;
               obj.width = Math.ceil(x_ratio * obj.width);
               obj.height = 100;
            }

    }
</script>