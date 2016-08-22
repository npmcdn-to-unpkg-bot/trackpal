
var group_users = {};
var user_coordinates = {};
var group_details = {};


var planes = {};

var initMap = function(){

    var mymap = L.map('mapid');
    mymap.locate({setView: true, maxZoom: 16});

    function onLocationError(e) {
    alert(e.message);
    }

    mymap.on('locationerror', onLocationError);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: 18,
      id: 'mapbox.streets',
      accessToken: 'pk.eyJ1IjoicGhhbmlnYW50aSIsImEiOiJjaXJ4dWJrbWQwMDh3MnpxZWJ5emh2djhrIn0.KF7Dwo7HD8Owe5uryb6eaQ'
    }).addTo(mymap);

    // var customIcon = L.icon({
    //     iconUrl: '/assets/marker-icon-2x.png',
    //     shadowUrl: '/assets/marker-shadow.png',
    //     iconSize:     [30, 50], // size of the icon
    //     shadowSize:   [10, 10], // size of the shadow
    //     iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
    //     // shadowAnchor: [10, 10],  // the same for the shadow
    //     // popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
    //   });

  // construct the correct array structure for leaflet display
  _.each(user_coordinates, function(val, key){
    // console.log('val,key', val, key, group_users  );
    _.each(val, function(position, index){
      var name = group_users[ position.user_id ].name;
      planes[ name ] = planes[ name ] || [];
      planes[ name ].push( [position.latitude, position.longitude] );
    });
  });
  // console.log('planes', planes);


  // leaflet display iteration
  _.each(planes, function(v,k){
    var lastPosition = _.last(v);

  //  console.log('v', v);
   var drawpolyline = new L.Polyline(v, {
      color: 'maroon',
      weight: 3,
      opacity: 0.5,
      smoothFactor: 1

    });
    drawpolyline.addTo(mymap);

    marker = L.userMarker(lastPosition, {pulsing:true, accuracy:100, smallIcon:false})
    				.bindPopup(k)
    				.addTo(mymap);
            // {icon: customIcon}
    // marker.setAccuracy(400); // 400 meters accuracy
  }); //each

  // This is the piece of code to display the destination displayed on to the page. The destination coordinates are based on the meetings point from the users page.

  var meetingPoint = L.circle([group_details.latitude, group_details.longitude], 100, {
      color: 'red',
      fillColor: '#f03',
      fillOpacity: 0.1
  }).addTo(mymap);


  setInterval(getLocation, 1000*10);

};

$(document).ready(function(){

  $.ajax({
    url: '/get_group_details',
    type: 'GET',
    dataType: 'json',
    data: {group_id:group_id}

    }).done(function(data){
      // console.log('success', data);
      group_users = data.users;
      user_coordinates = data.coordinates;
      group_details = data.group;
      console.log('user_coordinates',user_coordinates);

      initMap();
    })
    .fail(function(data){
      console.log('fail', data);
    });




//This below the leaflet API code which renders the maps of the location to set view based on the latitude and longitude




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

}); // document ready


//This is from HTML 5 doctor to read the location from the browser and throws error if the browser does not support the geolocation

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

//This is the function to get the current position of the user and sends it to the database via ajax request
function showPosition(position) {

  console.log('showPosition');
  $.ajax({
        url: '/submit_position',
        type: 'GET',
        // dataType: 'json',
        data: { lat: position.coords.latitude, lng: position.coords.longitude, group_id: group_id },
        contentType: 'application/json'})
        .done(function(data){
          console.log('success', data);
        })
        .fail(function(data){
          console.log('fail', data);
        });
}
