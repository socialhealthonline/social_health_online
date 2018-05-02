google.charts.load('current', {
  'packages': ['geochart'],
  'mapsApiKey': 'AIzaSyBkQxUFNtxxTiq2UqkNXQSHfwJUaLyus-s'
});
google.charts.setOnLoadCallback(drawMapForMembers);
google.charts.setOnLoadCallback(drawMapForAffiliates);

var options = {
  region: 'US',
  resolution: 'provinces',
  backgroundColor: '#f8f9fa',
  colorAxis: { minValue: 1, maxValue: 500, colors: ['#99CCFF', 'blue'] },
  legend: 'none'
};

function drawMapForMembers() {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'State');
  data.addColumn('number', 'Number of Members');
  for(state in gon.members_in_states) {
    data.addRow([us_states[state], gon.members_in_states[state]]);
  }

  var chart = new google.visualization.GeoChart(document.getElementById('members_chart'));
  chart.draw(data, options);
}

function drawMapForAffiliates() {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'State');
  data.addColumn('number', 'Number of Affiliates');
  for(state in gon.affiliates_in_states) {
    data.addRow([us_states[state], gon.affiliates_in_states[state]]);
  }

  var chart = new google.visualization.GeoChart(document.getElementById('affiliates_chart'));
  chart.draw(data, options);
}

var us_states = {
  'AL': 'Alabama',
  'AK': 'Alaska',
  'AS': 'American Samoa',
  'AZ': 'Arizona',
  'AR': 'Arkansas',
  'CA': 'California',
  'CO': 'Colorado',
  'CT': 'Connecticut',
  'DE': 'Delaware',
  'DC': 'District Of Columbia',
  'FM': 'Federated States Of Micronesia',
  'FL': 'Florida',
  'GA': 'Georgia',
  'GU': 'Guam',
  'HI': 'Hawaii',
  'ID': 'Idaho',
  'IL': 'Illinois',
  'IN': 'Indiana',
  'IA': 'Iowa',
  'KS': 'Kansas',
  'KY': 'Kentucky',
  'LA': 'Louisiana',
  'ME': 'Maine',
  'MH': 'Marshall Islands',
  'MD': 'Maryland',
  'MA': 'Massachusetts',
  'MI': 'Michigan',
  'MN': 'Minnesota',
  'MS': 'Mississippi',
  'MO': 'Missouri',
  'MT': 'Montana',
  'NE': 'Nebraska',
  'NV': 'Nevada',
  'NH': 'New Hampshire',
  'NJ': 'New Jersey',
  'NM': 'New Mexico',
  'NY': 'New York',
  'NC': 'North Carolina',
  'ND': 'North Dakota',
  'MP': 'Northern Mariana Islands',
  'OH': 'Ohio',
  'OK': 'Oklahoma',
  'OR': 'Oregon',
  'PW': 'Palau',
  'PA': 'Pennsylvania',
  'PR': 'Puerto Rico',
  'RI': 'Rhode Island',
  'SC': 'South Carolina',
  'SD': 'South Dakota',
  'TN': 'Tennessee',
  'TX': 'Texas',
  'UT': 'Utah',
  'VT': 'Vermont',
  'VI': 'Virgin Islands',
  'VA': 'Virginia',
  'WA': 'Washington',
  'WV': 'West Virginia',
  'WI': 'Wisconsin',
  'WY': 'Wyoming'
};
