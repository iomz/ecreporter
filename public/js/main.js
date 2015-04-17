var ws = new WebSocket(location.href.replace(/^http/, "ws"));

$(document).ready(function() {
    ws.onopen = function() {};
    ws.onerror = function(error) {
        window.alert(error);
    };
    ws.onmessage = function(msg) {
        var data = JSON.parse(msg.data);
        console.log(data);
    };
    ws.onclose = function() {};
});
