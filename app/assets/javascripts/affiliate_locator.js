
(function () {
  AFFILIATE_TABLE_COLUMNS = [
    {"name":"name", "title":"Name"},
    {"name":"address", "title":"Address"},
    {"name":"city", "title":"City"},
    {"name":"state", "title":"State"},
    {"name":"zip", "title":"Zip Code"},
    {"name":"phone", "title":"Phone Number"},
    {"name":"url", "title":"URL / Link"},
    {"name":"support_type", "title":"Support Type"},
  ]


  $(document).ready(function() {
    let filterTypeSelected = $("#affiliate-filter-toggle")[0].value;
    let filterForm = $("#affiliate-filter-form")[0];

    function displayFilter(filterTypeSelected){
      if(filterTypeSelected === "geo"){
        filterForm.innerHTML = '<div class="row"><div class="col-md-6">'+
        '<input type="text" name="city" placeholder="City" id="city-input" class="form-control">' +
        '</div>' +
        '<div class="col-md-6">' +
        '<input type="text" name="state" placeholder="State" id="state-input" class="form-control">' +
        '</div></div>';
        
      }else if(filterTypeSelected === "zip"){
        filterForm.innerHTML = '<div class="row">' +
        '<div class="col-xs-3 px-2">' +
        '<input type="text" name="zip" placeholder="Zip Code" id="zip-input" class="form-control">' +
        '</div></div>';
      }
    }

    displayFilter(filterTypeSelected);

    $('#affiliate-filter-toggle').on('change', function(){
      let filterTypeSelected = $("#affiliate-filter-toggle")[0].value;
      displayFilter(filterTypeSelected);
    });

    $('#affiliate-filter-button').on('click', function(){
      let filterTypeSelected = $("#affiliate-filter-toggle")[0].value;

      options={}

      if(filterTypeSelected === "geo"){
        let city = $("#city-input")[0].value;
        let state = $("#state-input")[0].value;

        options = {
          city: city,
          state: state
        }
      }else if(filterTypeSelected === "zip"){ 
        let zip = $("#zip-input")[0].value;

        options = {
          zip: zip
        }
      }

      // Clear out the table HTML
      $('.table')[0].innerHTML="";

      getAffiliates(
        function(data){
          console.log(data);
          jQuery(function($){
            $('#affiliate-locator-table').footable({
              "empty": "No results",
              "columns": AFFILIATE_TABLE_COLUMNS,
              "rows": data
            });
          });

          displayMarkers(data);
        },
        function(){},
        options
      );
    });

    $('#clear-affiliate-filter-button').on('click', function(){
      getAffiliates(
        function(data){
          $('.table')[0].innerHTML="";
          jQuery(function($){
            $('#affiliate-locator-table').footable({
              "empty": "No results",
              "columns": AFFILIATE_TABLE_COLUMNS,
              "rows": data
            });
          });
  
          displayMarkers(data);
        }
      );
    });


    
  });

  $(window).bind("load",function() {
    getAffiliates(
      function(data){
        jQuery(function($){
          $('#affiliate-locator-table').footable({
            "empty": "No results",
            "columns": AFFILIATE_TABLE_COLUMNS,
            "rows": data
          });
        });

        displayMarkers(data);
      }
    );
  });


  function displayMarkers(data){
    let geocoder;
    let map;

    function initialize() {
      geocoder = new google.maps.Geocoder();
      var latlng = new google.maps.LatLng(-34.397, 150.644);
      var mapOptions = {
        zoom: 5,
        center: latlng
      }
      map = new google.maps.Map(document.getElementById('affiliate-locator-map'), mapOptions);
    }
    initialize();
    
    let i = 0;
    // Display All the Markers
    data.forEach(row => {
      i += 1;
      let address = row.address + ", " + row.city + ", " + row.state;
      var contentString = '<div id="affiliate-marker-content">'+
            '<h3>' + row.name + '</h3>' +
            '<p>' + row.full_address + '</p>' +
            '<h6>Phone:</h6>' +
            '<p>' + (row.phone || "No Phone Number") + '</p>' +
            '<h6>Website:</h6>' +
            '<p>' + '<a href="'+ (row.url || "#") + '">' + (row.url || "No Website") + '</a>' + '</p>' +
            '</div>';

        var infowindow = new google.maps.InfoWindow({
          content: contentString
        });

      geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == 'OK') {
          map.setCenter(results[0].geometry.location);
          
        
          window.setTimeout(function() {
            var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location,
              title: 'Affiliate',
              animation: google.maps.Animation.DROP
            });

            marker.addListener('click', function() {
              infowindow.open(map, marker);
            });
          }, i * 200);
  

  
        } else {
          console.log('Geocode was not successful for the following reason: ' + status);
        }
      });
    });
  }
  
  function getAffiliates(success_func, error_func, filter_options={}) {
    const BASE_URL = "/affiliates";
  
    query = buildFilterQuery(filter_options);
  
    let url = BASE_URL + query;
  
    $.ajax({
      type: "GET",
      url: url,
      dataType: "json",
      success: function(data){
          success_func(data);
      },
      error: function (xhr, ajaxOptions, thrownError) {
        console.log(xhr.status);
        console.log(thrownError);
      }
    });
  }
  
  function buildFilterQuery(filter_options={}){
    let city = filter_options.city;
    let state = filter_options.state;
    let zip = filter_options.zip;
  
    query = "?";
  
    if(city && state){
      query += "state=" + state + "&" + "city=" + city;
    }
    else if(city){
      query += "city=" + city;
    }
    else if(state){
      query += "state=" + state;
    }else if(zip){
      query += "zip=" + zip;
    }else{
      query = "";
    }
    return query;
  }
})();