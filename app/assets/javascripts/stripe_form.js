$(document).ready(function() {

  $('#create_member').prop('disabled', true);

  $(document).on('change', '#termsCheckBox', function() {
    if(this.checked && $('#termsCheckBox').data('data_capcha')) {
      $('#create_member').prop('disabled', false);
    } else {
      $('#create_member').prop('disabled', true);
    }
  });

  thenCapchaIsSubmited = function() {
    $('#termsCheckBox').data('data_capcha', true);
    if ($('#termsCheckBox')[0].checked) {
      $('#create_member').prop('disabled', false);
    }
  };

  expiredRecapchaCallback = function() {
    $('#termsCheckBox').data('data_capcha', false);
    $('#create_member').prop('disabled', true);
  };

  var stripe = Stripe($("meta[name='stripe-key']").attr('content'));
  var elements = stripe.elements();
  var style = {
    base: {
      color: '#32325d',
      fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
      fontSmoothing: 'antialiased',
      fontSize: '16px',
      '::placeholder': {
        color: '#aab7c4'
      }
    },
    invalid: {
      color: '#dc3545',
      iconColor: '#dc3545'
    }
  };

  var card = elements.create('card', { style: style, hidePostalCode: true } );

  document.getElementById('creditOrDebit').addEventListener('click', function() {
    card.mount('#card-element');
    document.getElementById('debitBox').style.display = 'block';
    document.getElementById('achBox').style.display = 'none';
  });

  card.addEventListener('change', function(event) {
    var displayError = $('#card-errors');
    if (event.error) {
      displayError.text(event.error.message);
    } else {
      displayError.empty();
    }
  });

  document.getElementById("creditOrDebit").click();

  document.getElementById('ACHCard').addEventListener('click', function() {
    card.unmount('#card-element');
    document.getElementById('achBox').style.display = 'block';
    document.getElementById('debitBox').style.display = 'none';
  });

  var errorElement = $('.ach-error');

  $('#payment-form').submit(function( event ) {
    event.preventDefault();
    if(document.getElementById('creditOrDebit').checked) {
      var tokenData = {
        address_line1: $('#card_address').val(),
        address_city: $('#card_city').val(),
        address_state: $('#card_state').val()
      };

      stripe.createToken(card, tokenData).then(function (result) {
        if (result.error) {
          var errorElement = $('#card-errors');
          errorElement.show();
          errorElement.text(result.error.message);
        } else {
          stripeCardTokenHandler(result.token);
        }
      });
    } else {
      var bankAccountData = {
        country: 'us',
        currency: 'usd',
        routing_number: $('#routing-number').val(),
        account_number: $('#account-number').val(),
        account_holder_name: '',
        account_holder_type: $('#ach-type').val()
      };
      if(bankAccountData['account_number'] && bankAccountData['routing_number']){
        stripe.createToken('bank_account', bankAccountData).then(stripeAchTokenHandler);
      } else {
        showAchErrors(errorElement, 'Routing Number and/or Account Number can\'t be blank')
      }

    }

  });

  function stripeCardTokenHandler(token) {
    var form = document.getElementById('payment-form');
    var hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeToken');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput);
    form.submit();
  }

  function stripeAchTokenHandler(result) {
    errorElement.removeClass('visible');

    if (result.token) {
      var form = document.getElementById('payment-form');
      $('input[name="stripeToken"]').val(result.token.id);
      form.submit();
    } else if (result.error) {
      showAchErrors(errorElement, result.error.message);
    }
  }

  function showAchErrors(element, errors) {
    element.addClass('visible');
    element.text(errors);
  }

  calculate_price();

  $('#member_service_capacity').bind('keyup mouseup', function () {
    calculate_price();
  });

  $('#member_plan').change(function() {
    calculate_price();
  });

  function calculate_price() {
    var multiplier, year_price, month_price;
    var plan = $('#member_plan').find('option:selected').text();

    users = $('#member_service_capacity').val();

    switch (true) {
      case (users < 101):
        multiplier = 6;
        break;
      case (users < 251):
        multiplier = 5;
        break;
      default:
        multiplier = 4;
        break;
    }

    year_price = users * multiplier * 12;
    if (plan == 'Annual') {
      year_price *= 0.97;
      $('#total-price').text('$' + year_price.toFixed(2) + ' per year')
    }
    else {
      month_price = year_price / 12;
      period = 'month';
      $('#total-price').text('$' + month_price.toFixed(2) + ' per month ($' + year_price + ' per year)')
    }

  }
});
