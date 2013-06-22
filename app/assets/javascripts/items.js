$(document).ready(function(){
	$("#item_department").typeahead({source: ["DPG", "Lyberteam", "PSM", "Webteam"]})
	$("#item_make").typeahead({source: ["Dell", "Mac"]});
	$("#item_swap_cycle").typeahead({source: ["1-year", "2-years", "3-years"]});
});