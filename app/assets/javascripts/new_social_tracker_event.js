(function() {
  $(window).bind("load", function() {
    let selectedState = $("#social_event_log_state")[0].value;
    displayListOfCities(selectedState);

    $("#social_event_log_state").on("change", function() {
      let selectedState = $("#social_event_log_state")[0].value;
      displayListOfCities(selectedState);
    });

    $("#social_event_log_source").on("change", function() {
      let source = $("#social_event_log_source")[0].value;
      console.log(source);
      if(source === '0'){
        $("#social_event_log_event_categories").prop("disabled", false);
      }else if(source === '1'){        
        $("#social_event_log_event_categories").prop("disabled", true);
        $("#social_event_log_event_categories").val([]);
      }
    });

    $("form").on("click",".remove_category", function(event) {
      $(this).prev('input[type=hidden').val('1');
      $(this).closest('fieldset').hide();
      event.preventDefault();
    });

    $("form").on("click",".add_category", function(event) {
      let time = new Date().getTime();
      let regexp = new RegExp($(this).data('id'), 'g');
      $(this).before($(this).data('fields').replace(regexp, time))
      event.preventDefault();
    });
  });
  

  function displayListOfCities(selectedState){
    let citySelector = $("#social_event_log_city")[0];

    $.ajax({
      url: '/cities/' + selectedState,
      success: function(cities) {
        let options;
        cities.forEach(function(city) {
          options += '<option value="' + city + '">' + city + '</option>';
        });
        citySelector.innerHTML = options;
      }
    });
  }
})();