$(document).ready(function() {

  $('#send_contact').prop('disabled', true);

  thenCapchaIsSubmited = function() {
    $('#send_contact').prop('disabled', false);
  };

  expiredRecapchaCallback = function() {
    $('#send_contact').prop('disabled', true);
  };

});
