var ws = new WebSocket(location.href.replace(/^http/, "ws"));

function display(tags) {
    $("#report").empty();
    var newUl = $("<ul/>", {
        "class": "wrapper"
    });
    for (i=0; i<tags.length; i++) {
        var newH1 = $("<h1>"+tags[i]+"</h1>");
        var newLi = $("<div/>", {
            "class": "box"
        });
        newH1.appendTo(newLi);
        newLi.appendTo(newUl);
    }
    newUl.appendTo($("#report"));
}

$(document).ready(function() {
    ws.onopen = function() {
        console.log(ws);
    };
    ws.onerror = function(error) {
        window.alert(error);
    };
    ws.onmessage = function(msg) {
        console.log(msg);
        var tags = JSON.parse(msg.data).tags;
        display(tags);
    };
    ws.onclose = function() {};
});
