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

	$("#item_shipping_provider").on("change", function(){
		if($(this).val() != "") {
			$("#item_tracking_url").closest(".control-group").hide("slow");
		}else{
			$("#item_tracking_url").closest(".control-group").show("slow");
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
  check_barcode();
  responsiveCollapse();
});
jQuery(window).on("resize", function(){
  responsiveCollapse();
});

function responsiveCollapse(){
  $("[data-behavior='responsive-collapse-toggle']").each(function(){
    var toggler = $(this);
    var target  = $(toggler.data("target"));
    var indicator = $("i", toggler);
    do_collapse(toggler);
    if(jQuery(window).width() < 767){
      target.hide();
      indicator.attr("class", "icon-plus");
    }else{
      target.show()
      indicator.attr("class", "icon-minus");
    }
  });
}
function do_collapse(toggler){
  var target =    $(toggler.data("target"));
  var indicator = $("i", toggler);
  if(!toggler.data('process-toggle')){
    toggler.on('click', function(){
      target.slideToggle('slow');
      toggle_indicator_class(indicator);
    });
  }
  toggler.data('process-toggle', true);
}
function toggle_indicator_class(indicator){
  indicator.attr("class",
    indicator.attr("class") == "icon-plus" ? "icon-minus" : "icon-plus"
  );
}
function check_barcode() {
  var indicator_class = "[data-barcode-checker-indicator]";
  $(indicator_class).each(function(){
    update_barcode_checker_indicator_tooltip($(this));
  });
  $("[data-barcode-checker]").each(function(){
    var target = $(this);
    target.on('keyup', function(){
      var indicator = target.next(indicator_class);
      var value = $(this).val();
      if ( value.length == 14 ) {
        $.ajax(target.attr("data-barcode-checker-path") + "?barcode=" + value).done(function(data){
          if ( data ) {
            indicator.attr("class", "icon-remove");
          }else{
            indicator.attr("class", "icon-ok");
          }
          update_barcode_checker_indicator_tooltip(indicator);
        });
      }else{
        indicator.attr("class", "icon-remove");
        update_barcode_checker_indicator_tooltip(indicator);
      }
    });
  });
}
function update_barcode_checker_indicator_tooltip(indicator){
  indicator.tooltip('destroy');
  if (indicator.hasClass("icon-ok")) {
    indicator.tooltip({'title': 'Valid Barcode!'});
  } else if ( indicator.hasClass("icon-remove")) {
    indicator.tooltip({'title': 'This barcode is either invalid or already taken.'});
  }
}