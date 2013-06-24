$(document).ready(function(){
	$("[data-typeahead-options]").each(function(){
		var options = $(this).data("typeahead-options").split(",");
		$(this).prop("autocomplete", "off").typeahead({source: options});
	});
});