import {Socket} from "phoenix"
var $ = require('jquery');

let socket = new Socket("/scrawl_socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("scrawls", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

var last_scrawl = 0;

var process_scrawls = function process_scrawls(scrawls) {
  if (typeof(scrawls) === 'undefined' || scrawls.length == 0) {
    return;
  }
  scrawls.map(function(scrawl) {
    if (scrawl.id <= last_scrawl) {
      return;
    }
    $( "body" ).trigger({
      type: "scrawl",
      scrawl: scrawl
    });
    last_scrawl = scrawl.id
  });
  console.log("Last scrawl ID is " + last_scrawl)
};

var poll_with_location = function poll_with_location() { 
  window.setTimeout(function() {
    navigator.geolocation.getCurrentPosition(
      function(position) {
        channel.push(
          "scrawls",
          {last_scrawl: last_scrawl,
            point: {type: "Point", coordinates: [position.coords.longitude, position.coords.latitude]}
          }
        ).receive("ok", resp => {
          process_scrawls(resp.scrawls)
        })
        
      }
    );
    poll_with_location();
  }, 500);
};
poll_with_location();
export default socket
