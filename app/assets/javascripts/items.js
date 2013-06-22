$(document).ready(function(){
	$("#item_department").typeahead({source: ["DPG", "Lyberteam", "PSM", "Webteam"]})
	$("#item_make").typeahead({source: ["Dell", "Mac"]});
	$("#item_swap_cycle").typeahead({source: ["1-year", "2-years", "3-years"]});

	var service_code_parent = $("#item_express_service_code").closest(".control-group");
	service_code_parent.hide();
	$("#item_make").change(function(){
		if($(this).prop("value") == "Dell") {
			service_code_parent.slideToggle();
		}else{
			service_code_parent.slideToggle();
		}
	});
	
	$("#item_barcode").keyup(function(){
		if($(this).prop("value").length == 2) {
			$(this).prop("value", $(this).prop("value") + "00000000");
		}
	});
});