var L = require('leaflet');
var $ = require('jquery')

// todo: figure out a zoom level i guess
var zoom_level = 16;
var access_token = "pk.eyJ1IjoicmVsd2VsbCIsImEiOiJjaXVycW9oY2cwMDliMnltdG8xcHBydzZ0In0.jkmHg8TYCci9O02JcrtAsQ";

var draw_map = function draw_map(position) {
  var scrawl_map = L.map(
    'scrawlmap',
  ).setView(
    [position.coords.latitude, position.coords.longitude], 
    zoom_level
  );
  L.tileLayer(
    'https://api.mapbox.com/styles/v1/mapbox/streets-v10/tiles/256/{z}/{x}/{y}?access_token='+access_token, 
    {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: 18,
    }
  ).addTo(scrawl_map);
  scrawl_map.invalidateSize();
};

$(document).ready(function() {
  $('#scrawlmap').ready(function(){
    navigator.geolocation.getCurrentPosition(draw_map);
  });
});



