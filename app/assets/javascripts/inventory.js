function data_typeahead_options() {
	$("[data-typeahead-options]").each(function(){
		var options = $(this).data("typeahead-options").split(",");
		$(this).prop("autocomplete", "off").typeahead({source: options});
	});
}
$(document).ready(function(){data_typeahead_options()});
document.addEventListener("page:load", function(){data_typeahead_options()});
