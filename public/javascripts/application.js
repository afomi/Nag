// highlight the latest entry
function highlight_active_status(status) {
    $("." + status).first().addClass("active");
}

// Button Behaviors in the UI

$(function () {
    console.log('something');

    $("#trello_total").hover(
        function () {
            $("#trello_hover").css("display", "block");
        },
        function () {
            $("#trello_hover").css("display", "none");
        }
    );

    $('.edit').editable('/status/gmail',
        {
            id:'key',
            name:'value'
        }
    );

});
