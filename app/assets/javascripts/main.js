
var group_users = {};
var user_coordinates = {};
var group_details = {};
var planes = [];
// var drawpolyline = L.Polyline;
var mymap = {};
var radius = 0;

var user_markers = [];


//Initializing the map object

var initMap = function(){
  mymap = L.map('mapid');

  L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/streets-v9/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoicGhhbmlnYW50aSIsImEiOiJjaXJ4dWJrbWQwMDh3MnpxZWJ5emh2djhrIn0.KF7Dwo7HD8Owe5uryb6eaQ', {
        maxZoom: 15
      }).addTo(mymap);

  // mymap.locate({setView: true, maxZoom: 15});

  // mymap.on('locationfound', onLocationFound);


  //
  // function onLocationError(e) {
  //   alert('location error', e.message);
  // }
  // mymap.on('locationerror', onLocationError);

  getCurrentUserLocation(); // get our location and send to server
  updateLiveMap(user_coordinates); // initialise map display

  setInterval(getGroupUsersCoordinates, 1000*10); // get all user locations from server every 10s
  setInterval(getCurrentUserLocation, 1000*10); // get all user locations from server every 10s



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
          // console.log('user_coordinates',user_coordinates);
          initMap();
          // updateLiveMap(user_coordinates);
          var meetingPoint = L.circle([group_details.latitude, group_details.longitude], 500, {
                color: 'red',
                fillColor: '#f03',
                fillOpacity: 0.7
            }).addTo(mymap);

        })
        .fail(function(data){
          console.log('fail', data);
        });


});

//Getting the coordinates of the user every 20 seconds

var getGroupUsersCoordinates = function(){
  $.ajax({
    url: '/get_group_coordinates',
    type: 'GET',
    // dataType: 'json',
    data: { group_id: group_id },
    contentType: 'application/json'})
  .done(function(data){
    console.log('success', data.coordinates);
    coords = data.coordinates;
    // console.log("COORDS", coords);
    updateLiveMap(coords);

  })
  .fail(function(data){
    console.log('fail', data);
  });
};

//Drawing the coordinates on to the map

var updateLiveMap = function(coordinates){

  console.log('updateLiveMap()');

    // coordinates is an object indexed by user_id, with an array of coordinates as value
    // ... so this each is actually iterating over users
  _.each(coordinates, function(coords, user_id){
    // console.log(user_id, coords)
    var drawpolyline = new L.Polyline([], {
       color: 'blue',
       weight: 5,
       opacity: 0.7,
       smoothFactor: 1
     });

    _.each(coords,function(coord, index){
      drawpolyline.addLatLng( [coord.latitude, coord.longitude] );
    });
    drawpolyline.addTo(mymap);

    var last = [ _.last(coords).latitude, _.last(coords).longitude ];
    var marker = L.userMarker(last, {pulsing:true, accuracy:100, smallIcon:true})
    				.bindPopup( group_users[user_id].name )
    				.addTo(mymap);

    user_markers.push( marker );
  });  // end per-user iteration over coordinates

  // make sure map shows everyone
  var group = new L.featureGroup( user_markers );
  mymap.fitBounds( group.getBounds() );

};

var getCurrentUserLocation = function(){
  if (navigator.geolocation) {
    // var timeoutVal = 10 * 1000 * 1000;
    navigator.geolocation.getCurrentPosition(onLocationFound);
  }
  else {
    alert("Geolocation is not supported by this browser");
  }
};

var onLocationFound = function(position) {

  console.log('onLocationFound()', position);

  // var radius = e.accuracy / 2;
  // var lat = e.latlng.lat;
  // var lng = e.latlng.lng;

  //ignore if location has not changed!


  $.ajax({
    url: '/submit_position',
    type: 'GET',
    // dataType: 'json',
    // data:  {lat: lat, lng: lng, group_id: group_id },
    data: { lat: position.coords.latitude, lng: position.coords.longitude, group_id: group_id },
    contentType: 'application/json'})
    .done(function(data){
      console.log('success', data);

      // TODO: update the current-position marker and add a polyline point
      // for the current user (so our position will be more live than the next
      // AJAX getLocCoordinates call)

      // L.userMarker(e.latlng).addTo(mymap)
      //     .bindPopup("You are within " + radius + " meters from this point").openPopup();
      //
      // L.circle(e.latlng, radius).addTo(mymap);
    })
    .fail(function(data){
      console.log('fail', data);
    });
};
