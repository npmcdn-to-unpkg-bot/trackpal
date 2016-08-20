
var group_users = {};
var user_coordinates = {};
var group_details = {};
//
// id = 51
// group_users[id].name

//user.coordinates[userid] = coordinate_update[userid]

$(document).ready(function(){

  $.ajax({
    url: '/get_group_details',
    type: 'GET',
    dataType: 'json',
    data: {group_id:13}

    }).done(function(data){
      // console.log('success', data);
      group_users = data.users;
      user_coordinates = data.coordinates;
      group_details = data.group;


      // var p = {};
      // _.each(user_coordinates, function(v, k){
      //   console.log(v,k,group_users[ k ].name  );
      //
      //   p[ group_users[ k ].name ]  = p[ group_users[ k ].name ] || [];
      //
      //   console.log(p);
      //   _.each(v.coordinates, function(position, index){
      //
      //     p[ group_users[k].name ].push( [position.latitude, position.longitude]  );
      //
      //   });
      // });
      //
      // console.log('final', p);

    })
    .fail(function(data){
      console.log('fail', data);
    });




  var customIcon = L.icon({
      iconUrl: '/assets/marker-icon-2x.png',
      shadowUrl: '/assets/marker-shadow.png',

      iconSize:     [30, 50], // size of the icon
      shadowSize:   [10, 10], // size of the shadow
      iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
      shadowAnchor: [4, 62],  // the same for the shadow
      popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
    });


//This below the leaflet API code which renders the maps of the location to set view based on the latitude and longitude

var mymap = L.map('mapid').setView([-33.865143, 151.209900], 14);

L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox.streets',
    accessToken: 'pk.eyJ1IjoicGhhbmlnYW50aSIsImEiOiJjaXJ4dWJrbWQwMDh3MnpxZWJ5emh2djhrIn0.KF7Dwo7HD8Owe5uryb6eaQ'
}).addTo(mymap);

//This is the piece of code to display the destination displayed on to the page. The destination coordinates are based on the meetings point from the users page.

var circle = L.circle([group_details.latitude, group_details.longitude], 1000, {
    color: 'red',
    fillColor: '#f03',
    fillOpacity: 0.5
}).addTo(mymap);

//This is from HTML 5 doctor to read the location from the browser and throws error if the browser does not support the geolocation


function displayError(error) {
  var errors = {
    1: 'Permission denied',
    2: 'Position unavailable',
    3: 'Request timeout'
  };
  alert("Error: " + errors[error.code]);
}

//This should be the code which has the object of array locations of the people within the group
//This should only get the list of people who are in the group

// var userData = [];
//
// users.forEach(function(user){
//   var groupUser = {
//     name: user.userName;
//     id: user.id;
//     coordinates: []
//   };
//
// });

var planes = {
  "Phani": [[-33.8296,151.1258],[-33.8060,151.2948]],
  "Ameya": [[-33.8060,151.2948],[-33.8083,150.9821],[-33.81444,150.99696],[-33.86663, 151.02443]],
  "Satya": [[-33.865895,151.206400], [-33.866180,151.206722], [-33.866269, 151.206465], [-33.866305, 151.212258], [-33.866928, 151.212087]],
  "Sam": [[-33.866430,151.214447], [-33.866554,151.214919], [-33.866323, 151.214211], [-33.866251, 151.208053], [-33.866982, 151.207860]]
};

// This function below is for displaying the list of people and their markers based on the last positions
var names = [];
_.each(group_users, function(v, k){
names.push(v.name);
});

var coordinates = _.toArray(user_coordinates);


// var planes = _.object(names, coordinates[]);
// console.log(planes);




_.each(planes, function(v,k){
  var lastPosition = _.last(v);
  //
  // // var lastPosition = _.toArray(lastPos);
  // var randomColor = Math.floor(Math.random() * 256);
  // console.log(randomColor);
  //
  // console.log(v);
  var firstpolyline = new L.Polyline(v, {
    color: 'maroon',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1

  });
  firstpolyline.addTo(mymap);

  marker = new L.marker(lastPosition, {icon: customIcon})
  				.bindPopup(k)
  				.addTo(mymap);
}); //each

}); // document ready

function getLocation(){
  console.log('getLocation');
  if (navigator.geolocation) {
    // var timeoutVal = 10 * 1000 * 1000;
    navigator.geolocation.getCurrentPosition(showPosition);
  }
  else {
    alert("Geolocation is not supported by this browser");
  }
}

//This is the function to get the current position of the user
function showPosition(position) {

  console.log('showPosition');
  $.ajax({
        url: '/submit_position',
        type: 'GET',
        // dataType: 'json',
        data: { lat: position.coords.latitude, lng: position.coords.longitude },
        contentType: 'application/json'})
        .done(function(data){
          console.log('success', data);
        })
        .fail(function(data){
          console.log('fail', data);
        });
}
