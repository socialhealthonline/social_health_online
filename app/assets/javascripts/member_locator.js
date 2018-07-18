(function() {
  var AFFILIATE_TABLE_COLUMNS = [
    { name: "name", title: "Name" },
    { name: "address", title: "Address" },
    { name: "city", title: "City" },
    { name: "state", title: "State" },
    { name: "zip", title: "ZIP Code" },
    { name: "phone", title: "Phone Number" },
    { name: "url", title: "Website" }
  ];

  $(document).ready(function() {
    var filterTypeSelected = $("#member-filter-toggle")[0].value;
    var filterForm = $("#member-filter-form")[0];

    function displayFilter(filterTypeSelected) {
      if (filterTypeSelected === "geo") {
        filterForm.innerHTML =
          '<div class="row"><div class="col-md-6">' +
          '<input type="text" name="city" placeholder="City" id="city-input" class="form-control text-center">' +
          "</div>" +
          '<div class="col-md-6">' +
          buildStatesSelector('state-input', 'state') +
          "</div></div>";
      } else if (filterTypeSelected === "zip") {
        filterForm.innerHTML =
          '<div class="row">' +
          '<div class="col-md-12 px-2">' +
          '<input type="text" name="zip" placeholder="ZIP Code" id="zip-input" class="form-control">' +
          "</div></div>";
      }
    }

    displayFilter(filterTypeSelected);

    $("#member-filter-toggle").on("change", function() {
      var filterTypeSelected = $("#member-filter-toggle")[0].value;
      displayFilter(filterTypeSelected);
    });

    $("#member-filter-button").on("click", function() {
      var filterTypeSelected = $("#member-filter-toggle")[0].value;

      options = {};

      if (filterTypeSelected === "geo") {
        var city = $("#city-input")[0].value;
        var state = $("#state-input")[0].value;

        options = {
          city: city,
          state: state
        };
      } else if (filterTypeSelected === "zip") {
        var zip = $("#zip-input")[0].value;

        options = {
          zip: zip
        };
      }

      // Clear out the table HTML
      $(".table")[0].innerHTML = "";

      getMembers(
        function(data) {
          jQuery(function($) {
            $("#member-locator-table")
              .on({
                "ready.ft.table": function(e, ft) {
                  $("#member-locator-table > tbody")
                    .children()
                    .each(function(id, child){
                      $(child).on("click", function() {
                        row = data[id];
                        displayMarker(row);
                      });
                    });
                }
              })
              .footable({
                empty: "No Members",
                columns: AFFILIATE_TABLE_COLUMNS,
                rows: data,
              });
          });

          showMap();
        },
        function() {},
        options
      );
    });

  });

  $(window).bind("load", function() {
    getMembers(function(data) {
      jQuery(function($) {
        $("#member-locator-table")
        .on({
          "ready.ft.table": function(e, ft) {
            $("#member-locator-table > tbody")
              .children()
              .each(function(id, child)  {
                $(child).on("click", function() {
                  row = data[id];
                  displayMarker(row);
                });
              });
          }
        })
        .footable({
          empty: "No Members",
          columns: AFFILIATE_TABLE_COLUMNS,
          rows: data,
        });
      });

      showMap();
    });
  });

  function displayMarker() {
    var geocoder = new google.maps.Geocoder();
    var map;

    function initialize() {
      var latlng = new google.maps.LatLng(41.850033, -87.6500523);
      var mapOptions = {
        zoom: 5,
        center: latlng
      };
      map = new google.maps.Map(
        document.getElementById("member-locator-map"),
        mapOptions
      );
    }
    initialize();

    var address = row.address + ", " + row.city + ", " + row.state;
    var contentString =
      '<div id="member-marker-content">' +
      "<h3>" +
      row.name +
      "</h3>" +
      "<h6>Address:</h6>" +
      "<p>" +
      row.full_address +
      "</p>" +
      "<h6>Phone:</h6>" +
      "<p>" +
      (row.phone || "No Phone Number") +
      "</p>" +
      "<h6>Website:</h6>" +
      "<p>" +
      (row.url || "No Website")
      "</p>" +
      "</div>";

    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    geocoder.geocode({ address: address }, function(results, status) {
      if (status == "OK") {
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location,
          title: row.name,
          animation: google.maps.Animation.DROP
        });
        infowindow.open(map, marker);
      } else {
        console.log(
          "Geocode was not successful for the following reason: " + status
        );
      }
    });
  }

  function showMap() {
    function initialize() {
      var mapOptions = {
        zoom: 5,
        center: new google.maps.LatLng(41.850033, -87.6500523)
      };
      map = new google.maps.Map(
        document.getElementById("member-locator-map"),
        mapOptions
      );
    }
    initialize();
  }

  function getMembers(success_func, error_func, filter_options = {}) {
    const BASE_URL = "/members";

    query = buildFilterQuery(filter_options);

    var url = BASE_URL + query;

    $.ajax({
      type: "GET",
      url: url,
      dataType: "json",
      success: function(data) {
        success_func(data);
      },
      error: function(xhr, ajaxOptions, thrownError) {
        console.log(xhr.status);
        console.log(thrownError);
      }
    });
  }

  function buildFilterQuery(filter_options = {}) {
    var city = filter_options.city;
    var state = filter_options.state;
    var zip = filter_options.zip;

    query = "?";

    if (city && state) {
      query += "state=" + state + "&" + "city=" + city;
    } else if (city) {
      query += "city=" + city;
    } else if (state) {
      query += "state=" + state;
    } else if (zip) {
      query += "zip=" + zip;
    } else {
      query = "";
    }
    return query;
  }
})();
