
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
    getAffiliates(
      function(data){
        console.log(data);
        jQuery(function($){
          $('.table').footable({
            "columns": AFFILIATE_TABLE_COLUMNS,
            "rows": data
          });
        });
      }
    );
  });

  // Colums
//   [
//   {"name":"id","title":"ID","breakpoints":"xs sm","type":"number","style":{"width":80,"maxWidth":80}},
//   {"name":"firstName","title":"First Name"},
//   {"name":"lastName","title":"Last Name"},
//   {"name":"something","title":"Never seen but always around","visible":false,"filterable":false},
//   {"name":"jobTitle","title":"Job Title","breakpoints":"xs sm","style":{"maxWidth":200,"overflow":"hidden","textOverflow":"ellipsis","wordBreak":"keep-all","whiteSpace":"nowrap"}},
//   {"name":"started","title":"Started On","type":"date","breakpoints":"xs sm md","formatString":"MMM YYYY"},
//   {"name":"dob","title":"Date of Birth","type":"date","breakpoints":"xs sm md","formatString":"DD MMM YYYY"},
//   {"name":"status","title":"Status"}
// ]
  

// Rows
// [
//   {"id":7501,"firstName":"Lizzee","lastName":"Shumpert","something":1336187977415,"jobTitle":"Photocopying Equipment Repairer","started":1346115318935,"dob":-311835700063,"status":"Suspended"},
//   {"id":7502,"firstName":"Solomon","lastName":"Moudy","something":1306407279004,"jobTitle":"Drywall Stripper","started":1363427484754,"dob":592533207125,"status":"Active"},
//   {"id":7503,"firstName":"Jason","lastName":"Furniss","something":1324022863253,"jobTitle":"Drywall Stripper","started":1343299525278,"dob":632581270452,"status":"Suspended"},
//   {"id":7504,"firstName":"Rivka","lastName":"Stever","something":1273833681456,"jobTitle":"Cloak Room Attendant","started":1332334347331,"dob":464583076174,"status":"Active"},
//   {"id":7505,"firstName":"Anonina","lastName":"Sinclair","something":1328578764629,"jobTitle":"Die Designer","started":1376907478323,"dob":70426362769,"status":"Active"},
//   {"id":7506,"firstName":"Karon","lastName":"Difranco","something":1282246300808,"jobTitle":"Meat Packager","started":1378806328049,"dob":364400905388,"status":"Suspended"},
//   {"id":7507,"firstName":"Celia","lastName":"Sprinkle","something":1294646412973,"jobTitle":"Broadcast Maintenance Engineer","started":1300141646964,"dob":399002088565,"status":"Active"},
//   {"id":7508,"firstName":"Lauri","lastName":"Stgelais","something":1336488058398,"jobTitle":"Military Science Teacher","started":1270273281534,"dob":-2862081750,"status":"Active"},
//   {"id":7509,"firstName":"Ardelia","lastName":"Leinen","something":1347514084798,"jobTitle":"Route Sales Person","started":1369574013729,"dob":559902281990,"status":"Suspended"},
//   {"id":7510,"firstName":"Kaci","lastName":"Resler","something":1352525312363,"jobTitle":"Internal Medicine Nurse Practitioner","started":1273520360552,"dob":-15561277796,"status":"Active"},
// ]
  
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