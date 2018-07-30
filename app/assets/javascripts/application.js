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
//= require moment
//= require footable.min
//= require activestorage
//= require popper
//= require bootstrap-sprockets
//= require flatpickr/dist/flatpickr.min
//= require fullcalendar
//= require nested_form_fields
//= require select2

$(document).ready(function() {
  $(".flatpickr-date").flatpickr({
    allowInput: false,
    dateFormat: 'Y-m-d'
  });

  $(".flatpickr-date-time").flatpickr({
    enableTime: true,
    dateFormat: 'Y-m-d h:i K'
  });

  $('.matchmaker_popover').popover({
    html:true
  });

  var resipients_select = $('.resipients-select');
  resipients_select.select2({
    theme: 'bootstrap',
    minimumInputLength: 1
  });

  resipients_select.val(gon.recipient_id);
  resipients_select.trigger('change');

  $(".events-flash").click(function(){
    $('#helper-method').html("<div class='alert alert-danger alert-dismissible fade show' role='alert'>"
                              + "<button aria-label='Close' class='close' data-dismiss='alert' type='button'>"
                                + "<span aria-hidden='true'>×</span>"
                              + "</button>"
                                + "This event is currently at full capacity so you may not RSVP at this time."
                              + "</div>");
  });

  function communityTabsOnLoad() {
    $('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
      localStorage.setItem('activeTab', $(e.target).attr('href'));
    });

    var activeTab = localStorage.getItem('activeTab');

    if(activeTab){
      $('#communityTabs a[href="' + activeTab + '"]').tab('show');
    }
  }

  communityTabsOnLoad();

  $('#member_logo, #user_avatar').change(function(){
    var max_exceeded_message = 'This file exceeds the maximum allowed file size (3 mb).';
    var ext_error_message = 'Only image files with extensions .jpg, .jpeg, .gif, or .png are allowed.';
    var allowed_extension = ["jpg", 'jpeg', 'gif', 'png'];

    var input = $(this);
    var ext_name;
    var max_file_size = $(this).data('max-file-size');
    var size_exceeded = false;
    var extError = false;

    hide_errors();

    $.each(this.files, function() {
      if (this.size && max_file_size && this.size > parseInt(max_file_size)) { size_exceeded = true; }
      ext_name = this.name.split('.').pop();
      if ($.inArray(ext_name, allowed_extension) == -1) { extError = true; }
    });

    if (size_exceeded) show_error(max_exceeded_message);
    if (extError) show_error(ext_error_message);

    function show_error(message){
      input.addClass('is-invalid');
      $('#file-field').append('<small class="text-danger error-msg">' + message + '</small>');
      $(':input[type="submit"]').prop('disabled', true);
    }

    function hide_errors() {
      input.removeClass('is-invalid');
      $('.error-msg').hide();
      $(':input[type="submit"]').prop('disabled', false);
    }
  });

  // remove saved password from profile input field
  $('#profile-password').val('');

  $('.matchmaker_popover').popover({
    trigger: 'focus'
  });

});

var US_STATES = {
  'Alabama': 'AL',
  'Alaska': 'AK',
  'Arizona': 'AZ',
  'Arkansas': 'AR',
  'California': 'CA',
  'Colorado': 'CO',
  'Connecticut': 'CT',
  'Delaware': 'DE',
  'District Of Columbia': 'DC',
  'Florida': 'FL',
  'Georgia': 'GA',
  'Hawaii': 'HI',
  'Idaho': 'ID',
  'Illinois': 'IL',
  'Indiana': 'IN',
  'Iowa': 'IA',
  'Kansas': 'KS',
  'Kentucky': 'KY',
  'Louisiana': 'LA',
  'Maine': 'ME',
  'Maryland': 'MD',
  'Massachusetts': 'MA',
  'Michigan': 'MI',
  'Minnesota': 'MN',
  'Mississippi': 'MS',
  'Missouri': 'MO',
  'Montana': 'MT',
  'Nebraska': 'NE',
  'Nevada': 'NV',
  'New Hampshire': 'NH',
  'New Jersey': 'NJ',
  'New Mexico': 'NM',
  'New York': 'NY',
  'North Carolina': 'NC',
  'North Dakota': 'ND',
  'Ohio': 'OH',
  'Oklahoma': 'OK',
  'Oregon': 'OR',
  'Pennsylvania': 'PA',
  'Rhode Island': 'RI',
  'South Carolina': 'SC',
  'South Dakota': 'SD',
  'Tennessee': 'TN',
  'Texas': 'TX',
  'Utah': 'UT',
  'Vermont': 'VT',
  'Virginia': 'VA',
  'Washington': 'WA',
  'West Virginia': 'WV',
  'Wisconsin': 'WI',
  'Wyoming': 'WY'
};

function buildStatesSelector(id, name) {
  var selector = '<select class="form-control" name="' + name + '"' + 'id="' + id + '"' + '>';
  Object.keys(US_STATES).forEach(state => {
    selector += '<option value="' + US_STATES[state] + '">' + state + '</option>';
  });
  selector += '</select>';

  return selector;
}
