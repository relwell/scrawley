var $ = require('jquery');

$('document').ready(() => {
  navigator.geolocation.getCurrentPosition(
    function(position) {
      $('input.location').attr(
        'value', 
        JSON.stringify({type: "Point", 
                        coordinates: [position.coords.longitude, position.coords.latitude]})
      );
    }
  );
});