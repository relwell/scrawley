var L = require('leaflet');
var $ = require('jquery')

// todo: figure out a zoom level i guess
var zoom_level = 16;
var access_token = "pk.eyJ1IjoicmVsd2VsbCIsImEiOiJjaXVycW9oY2cwMDliMnltdG8xcHBydzZ0In0.jkmHg8TYCci9O02JcrtAsQ";
var scrawl_map;

var draw_map = function draw_map(position) {
  scrawl_map = L.map(
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

var geojsonMarkerOptions = {
  radius: 8,
  fillColor: "#ff7800",
  color: "#000",
  weight: 1,
  opacity: 1,
  fillOpacity: 0.8
};

function onEachFeature(feature, layer) {
  // does this feature have a property named popupContent?
  if (feature.properties && feature.properties.popupContent) {
    layer.bindPopup(feature.properties.popupContent);
  }
}

$(document).ready(function() {
  $('#scrawlmap').ready(function(){
    navigator.geolocation.getCurrentPosition(draw_map);
    $('body').on('scrawl', function(scrawl_event) {
      var scrawl = scrawl_event.scrawl;
      L.geoJSON({
        type: "Feature",
        properties: {
          name: "!",
          popupContent: scrawl.text
        },
        geometry: scrawl.location
      }, {
        onEachFeature: onEachFeature,
        pointToLayer: function (feature, latlng) {
          return L.circleMarker(latlng, geojsonMarkerOptions);
        }
      }).addTo(scrawl_map);
    });
  });
});





