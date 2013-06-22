$(document).ready(function(){
	$("#item_department").typeahead({source: ["DPG", "Lyberteam", "PSM", "Webteam"]})
	$("#item_make").typeahead({source: ["Dell", "Mac"]});
	$("#item_swap_cycle").typeahead({source: ["1-year", "2-years", "3-years"]});
	
	$("#item_barcode").keyup(function(){
		if($(this).prop("value").length == 2) {
			$(this).prop("value", $(this).prop("value") + "00000000");
		}
	});
});