// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Onload Observations
$(function() {
  $('#select_category').change(select_category);
  $('#select_town').change(select_town);
  $('.print_coupon_link').click(function(e) { display_print_coupon($(this).attr('href')); e.preventDefault(); return false; });
});

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

function display_print_coupon(loc) { 
  var disp_settings="height=500,width=500,toolbar=no,location=no,directories=no,menubar=no,resizable=no,left=50,top=20,scrollbars=no";    
  var print_window = window.open(loc, 'print_window', disp_settings);
  if (window.focus) {print_window.focus()};
  print_window.onload =function() {    
    print_window.print();
    print_window.close();
  };
}   
