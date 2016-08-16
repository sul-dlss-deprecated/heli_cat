jQuery(document).on("turbolinks:load", function(){
	$("[data-typeahead-options]").each(function(){
		var options = $(this).data("typeahead-options").split(",");
		$(this).prop("autocomplete", "off").typeahead({source: options});
	});
	$("[data-toggle='tooltip']").each(function(){
		$(this).tooltip();
	});
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
});