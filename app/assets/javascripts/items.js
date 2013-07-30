function item_edit_typeahead(){
	$("#item_department").prop("autocomplete", "off").typeahead({source: ["DPG", "Lyberteam", "PSM", "Webteam"]})
	$("#item_make").prop("autocomplete", "off").typeahead({source: ["Dell", "Mac"]});
	$("#item_swap_cycle").prop("autocomplete", "off").typeahead({source: ["1-year", "2-years", "3-years"]});
}
function handle_dell_service_code(){
	var service_code_parent = $("#item_express_service_code").closest(".control-group");
	service_code_parent.hide();
	$("#item_make").change(function(){
		if($(this).prop("value") == "Dell") {
			service_code_parent.show("slow");
		}else{
			service_code_parent.hide("slow");
		}
	});
}
function autofill_barcode(){
	$("#item_barcode").keyup(function(){
		if($(this).prop("value").length == 2) {
			$(this).prop("value", $(this).prop("value") + "00000000");
		}
	});
}
function swap_value_for_current_user(){
	$("[data-toggle='current-user']").on("click", function(){
		var link = $(this);
		var user = $(this).attr("data-current-user");
		var target = $($(this).attr("data-target"));
		target.attr("value", user);
		return false;
	});
}
$(document).ready(function(){item_edit_typeahead(); handle_dell_service_code(); autofill_barcode(); swap_value_for_current_user()});
document.addEventListener("page:load", function(){item_edit_typeahead(); handle_dell_service_code(); autofill_barcode(); swap_value_for_current_user()});