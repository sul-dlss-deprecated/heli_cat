jQuery(document).on("turbolinks:load", function(){
	$("body").on("click", "[data-toggle='tracking']", function(){
		var tracking_container = $("[data-tracking-container]");
		var link = $(this);
		var update_link = link.prop("href");
		var link_has_update = (/\/update$/.test(update_link));
		$.get(link.prop("href"), function(data){
			if(!link_has_update){
				update_link += "/update";
			}
			tracking_container.html("<a href='" + update_link + "' data-toggle='tracking'>Update Tracking Information</a>");
			for(i=0;i<data.length;i++){
				tracking_container.append("<div class='tracking_activity'>" + data[i] + "</div>");
			}
		});
		if(link_has_update){
			tracking_container.hide("slow");
			tracking_container.show("slow");	
		}
		return false;
	});
});