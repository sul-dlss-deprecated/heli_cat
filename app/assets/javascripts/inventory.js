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
$(document).ready(function(){data_typeahead_options(); tooltips()});
document.addEventListener("page:load", function(){data_typeahead_options(); tooltips()});
