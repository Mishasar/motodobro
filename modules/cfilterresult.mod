<?php	
	if (isset($_REQUEST['motoGroup']) and $_REQUEST['motoGroup'] > 0):
		$filter_state = 1;
		$state_value = $_REQUEST['motoGroup'];
	endif;
	if (isset($_REQUEST['motoBrand']) and $_REQUEST['motoBrand'] > 0):
		$filter_state = 2;
		$state_value = $_REQUEST['motoBrand'];		
	endif;
	if (isset($_REQUEST['motoYear']) and $_REQUEST['motoYear'] > 0):
		$filter_state = 3;
		$state_value = $_REQUEST['motoYear'];		
	endif;
	if (isset($_REQUEST['motoModel']) and $_REQUEST['motoModel'] > 0):
		$filter_state = 4;
		$state_value = $_REQUEST['motoModel'];	
	endif;	
	switch ($filter_state) {
		case 1:	include ('cgroup.mod'); break;
		case 2:	include ('cbrand.mod'); break;
		case 3:	include ('cmodel.mod'); break;
		case 4:	include ('cmodelunits.mod'); break;
		default: include ('index.mod'); break;		
	}	
?>