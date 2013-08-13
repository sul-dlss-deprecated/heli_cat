jQuery(document).on("ready page:load", function(){
	$("#item_department").prop("autocomplete", "off").typeahead({source: ["DPG", "Lyberteam", "PSM", "Webteam"]})
	$("#item_make").prop("autocomplete", "off").typeahead({source: ["Dell", "Mac"]});
	$("#item_swap_cycle").prop("autocomplete", "off").typeahead({source: ["1-year", "2-years", "3-years"]});
	
	var service_code_parent = $("#item_express_service_code").closest(".control-group");
	service_code_parent.hide();
	$("#item_make").change(function(){
		if($(this).prop("value") == "Dell") {
			service_code_parent.show("slow");
		}else{
			service_code_parent.hide("slow");
		}
	});
	$("#item_barcode").keyup(function(){
		if($(this).prop("value").length == 2) {
			$(this).prop("value", $(this).prop("value") + "00000000");
		}
	});
	$("[data-toggle='current-user']").on("click", function(){
		var link = $(this);
		var user = $(this).attr("data-current-user");
		var target = $($(this).attr("data-target"));
		target.attr("value", user);
		return false;
	});
  responsiveCollapseFilterBy();
});
jQuery(window).on("resize", function(){
  responsiveCollapseFilterBy();
});

function responsiveCollapseFilterBy(){
	if(jQuery(window).width() <= 767){
		collapseFilterBy(".responsive-collapse");
	}else{
		$(".responsive-collapse [data-toggle='filter-by']").each(function(){
			$(this).parent().show();
		});
		$(".responsive-collapse").each(function(){
			var collapse_parent = $(this);
			collapse_parent.off("click", ".filter-by");
			$(this).data("collapse-processed", false);
		});
	}
}

function collapseFilterBy(selector){
	if(!$(selector).data("collapse-processed")){
		// Handle embeded Filter By toggles
		$(selector + " [data-toggle='filter-by']").each(function(){
			$(this).parent().hide();
		});
		$(selector).each(function(){
			var collapse_parent = $(this);
			collapse_parent.on("click", ".filter-by", function(){
				$("[data-toggle='filter-by']", collapse_parent).each(function(){
					$(this).parent().slideToggle();
				});
			});
			$(this).data("collapse-processed", true);
		});
	}
}