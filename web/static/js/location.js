var $ = require('jquery');

$('document').ready(function() {
  navigator.geolocation.getCurrentPosition(
    function(position) {
      console.log(position.coords);
      $('input.location').attr('value', JSON.stringify({type: "Point", coordinates: [position.coords.longitude, position.coords.latitude]}));
    }
  );
});