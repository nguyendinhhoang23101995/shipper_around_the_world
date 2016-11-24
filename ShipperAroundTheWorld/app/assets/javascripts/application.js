// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

function internal_link_click (link) {
	// Make sure this.hash has a value before overriding default behavior
	if (link.hash !== "") {
		// Prevent default anchor click behavior
		event.preventDefault();

		// Store hash
		var hash = link.hash;

		// Using jQuery's animate() method to add smooth page scroll
		// The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
		$('html, body').animate({
			scrollTop: $(hash).offset().top
		}, 900, function(){
		
		// Add hash (#) to URL when done scrolling (default click behavior)
		window.location.hash = hash;
		});
	} // End if
}

function toggleMessList(id){
	if($("#list-" + id).is(":visible") == false){
		$("#list-" + id).toggle();
		$("div#" + id).html("<a onclick=\"toggleMessList("+ id +")\">Message List" + 
							   "<span class=\"glyphicon " +
		 					   "glyphicon-chevron-up\" aria-hidden=\"true\"></span></a>");
	}
	else{
		$("#list-" + id).toggle();
		$("div#" + id).html("<a onclick=\"toggleMessList("+ id +")\">Message List" + 
							   "<span class=\"glyphicon " +
		 					   "glyphicon-chevron-down\" aria-hidden=\"true\"></span></a>");
	}
}