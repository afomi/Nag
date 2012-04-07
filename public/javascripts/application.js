// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



// Button Behaviors in the UI

$(function () {
     console.log('something');
    $("#trello_total").hover(
        function () {
            console.log('over');
            $("#trello_hover").css("display", "block");
        },
        function () {
            console.log('out');
            $("#trello_hover").css("display", "none");
        }
    );

});

