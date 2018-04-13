// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require rails-ujs
//= require footable.min
//= require activestorage
//= require popper
//= require fontawesome-all
//= require bootstrap
//= require flatpickr/dist/flatpickr.min
//= require moment
//= require fullcalendar

$(document).ready(function() {
  $(".flatpickr-date").flatpickr({
    allowInput: true,
    dateFormat: 'Y-m-d'
  });
  $(".flatpickr-date-time").flatpickr({
    enableTime: true,
    dateFormat: 'Y-m-d h:i K'
  });

  jQuery(function($){
    $('.table').footable();
  });
});
