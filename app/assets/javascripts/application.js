// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require stickyFooter
//= require foundation
//= reqiure foundation.alerts
//= require libs/jquery-ui-1.10.1.custom.min.js

$(function() { 
	$(document).foundation(); 

    /* Active highlighting for side menu 
       Would prefer not to do this here, but there's something going on with putting the script inside the nav that doesn't work
       Ok here for now; it works anyway. Can't do pure inline JS because it's doing redirects. 
       
     Concept is to have the page that's loading the menu set an "active_section" hidden field
     If we're loading a page that doesn't have a side menu, it won't find it and will do nothing
     Otherwise, the "li" elements have ids corresponding to the section names. Find the right one and set the active status. */

});
