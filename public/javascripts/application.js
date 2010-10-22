// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Onload Observations
$(function() {
  $('#select_category').change(select_category);
  $('#select_town').change(select_town);
  $('#filter_category').change(filter_category);
  $('#filter_town').change(filter_town);
  $('.list_refine_filter_option_remove').click(remove_filter);
  $('#select_zip').focusin(clear_select_zip)
  $('#select_zip').focusout(restore_select_zip)
  $('#select_zip_find').click(select_zip)
  $('#select_distance').change(select_distance)
  $('.print_coupon_link').click(function(e) { display_print_coupon($(this).attr('href')); e.preventDefault(); return false; });
  if ($('#featured_coupons').length>0) {
		$('#featured_selector_prev').click(featured_show_prev);
		$('#featured_selector_next').click(featured_show_next);
		$('.featured_selector_num').click(function(e) { featured_show_num($(this).html()) });
		if ($('.featured_coupon').length>0) {
			featured_show_num(1);	
		}
	}
});

// Variables
var featured_timeout;

function select_category() {
  if (this.value != "") {
    window.location = "/"+(this.value).replace(" ", "-")+"-Coupons/c/";
  }
}

function select_town() {
  if (this.value != "") {
    window.location = "/"+(this.value).replace(" ", "-")+"-Coupons/t/";
  }
}

function filter_town() {
  if (this.value != "") {
    var loc = removeParam('page', document.URL);
    window.location = loc+(loc.indexOf("?")!=-1?"&":"?")+"filter_town="+(this.value).replace(" ", "-");
  }
}

function filter_category() {
  if (this.value != "") {
    var loc = removeParam('page', document.URL);
    window.location = loc+(loc.indexOf("?")!=-1?"&":"?")+"filter_category="+(this.value).replace(" ", "-");
  }
}

function remove_filter() {
  window.location = removeParam($(this).attr('data-param'), document.URL);
}

function clear_select_zip() {
  if (this.value == "Enter ZIP Code") {
    this.value = ""; 
  }
}

function restore_select_zip() {
  if (this.value == "") {
    this.value = "Enter ZIP Code"
  }
}

function select_zip() {
  if ($('#select_zip').val() != "Enter ZIP Code") {
    window.location =  "/Coupons/d?zip="+$('#select_zip').val();
  }
}

function select_distance() {
  if (this.value != "") {
    var loc = removeParam('distance', document.URL);
    window.location = loc+(loc.indexOf("?")!=-1?"&":"?")+"distance="+(this.value);
  }
}

function display_print_coupon(loc) { 
  var disp_settings="height=500,width=500,toolbar=no,location=no,directories=no,menubar=no,resizable=no,left=50,top=20,scrollbars=no";    
  var print_window = window.open(loc, 'print_window', disp_settings);
}   
	
function featured_cycle() {
	clearTimeout(featured_timeout);	
	featured_timeout = setTimeout("featured_show_next()", 7*1000);
}

function featured_show_next() {
	featured_cycle();
	var elem = featured_hide_current();
	if (elem.next('.featured_coupon').length>0){
		elem.next('.featured_coupon').fadeIn('slow');
	} else {
		$('.featured_coupon:first').fadeIn('slow');	
	}
}

function featured_show_prev() {
	featured_cycle();
	var elem = featured_hide_current();
	if (elem.prev('.featured_coupon').length>0){
		elem.prev('.featured_coupon').fadeIn('slow');
	} else {
		$('.featured_coupon:last').fadeIn('slow');	
	}
}

function featured_show_num(num) {
	featured_cycle();
	var elem = featured_hide_current();
	$('#featured_coupon_'+num).fadeIn('slow');	
}

function featured_hide_current() {
	var elem = $('.featured_coupon:visible:first');
	elem.fadeOut('slow');
	return elem;
}

function removeParam(param,url) {
 var regex = new RegExp("&?" + param + "=[^&]+"); 
 return url.replace(regex,'');
}