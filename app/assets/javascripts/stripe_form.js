$(document).ready(function() {

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
    document.getElementById('debitLabel').style.display = 'block';
  });
 
  card.addEventListener('change', function(event) {
    var displayError = $('#card-errors');
    if (event.error) {
      displayError.text(event.error.message);
    } else {
    displayError.empty();
    }
  });
 
  $('#payment-form').submit(function( event ) {
    if(document.getElementById('creditOrDebit').checked) {
      event.preventDefault();
      stripe.createToken(card).then(function(result) {
        if (result.error) {
          var errorElement = $('#card-errors');
          errorElement.text(result.error.message);
        } else {
          stripeTokenHandler(result.token);
        }
      });
    }
  });
  
  document.getElementById("creditOrDebit").click();
  
  document.getElementById('ACHCard').addEventListener('click', function() {
    card.unmount('#card-element');
    document.getElementById('debitLabel').style.display = 'none';
  });

  function stripeTokenHandler(token) {
    var form = document.getElementById('payment-form');
    var hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeToken');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput);
    form.submit();
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
      $('#total-price').text('$' + month_price.toFixed(2) + ' per month ($' + year_price + 'per year)')
    }

  }
});
