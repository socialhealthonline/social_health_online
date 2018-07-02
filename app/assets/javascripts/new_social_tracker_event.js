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
          $('.not_sho_category').hide();
          $("#social_event_log_event_category").prop("disabled", false);
        }else if(source === '1'){
          $('.not_sho_category').show();
          $("#social_event_log_event_category").prop("disabled", true);
      }
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