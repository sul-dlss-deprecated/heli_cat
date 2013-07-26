function data_typeahead_options() {
	$("[data-typeahead-options]").each(function(){
		var options = $(this).data("typeahead-options").split(",");
		$(this).prop("autocomplete", "off").typeahead({source: options});
	});
}
function tooltips(){
	$("[data-toggle='tooltip']").each(function(){
		$(this).tooltip();
	});
}
function purchasing_workflow_checkboxes(){
	var purchased = $("input[type='checkbox']#item_purchased");
	var received = $("input[type='checkbox']#item_received");
	received.on("change", function(){
		if($(this).prop("checked")){
		  purchased.prop("checked", true);
		}
	});
	purchased.on("change", function(){
		if(!$(this).prop("checked")){
		  received.prop("checked", false);
		}
	});
}
$(document).ready(function(){data_typeahead_options(); tooltips(); purchasing_workflow_checkboxes()});
document.addEventListener("page:load", function(){data_typeahead_options(); tooltips(); purchasing_workflow_checkboxes()});
