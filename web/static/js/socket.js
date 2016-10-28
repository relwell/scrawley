import {Socket} from "phoenix"

let socket = new Socket("/scrawl_socket", {params: {token: window.userToken}});

socket.connect();

export default socket