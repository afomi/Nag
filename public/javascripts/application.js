// Helper Methods

// set the 25 minute times
function setMessage() {
  var minutes = 25;
  setTimeout("alertMessage()", 60000 * minutes);
}

// highlight the latest entry
function highlight_active_status(status) {
  $("." + status).first().addClass("active");
}

function alertMessage() {
  alert("Nag.");
}

function updateTime() {
  var d = new Date;
  $("#timer").text(d.strftime("%I:%M %P"));
}

// On Start
$(function () {

  window.setInterval(function () {
      updateTime();
    },
    60000);

  $("#trello_total").hover(
    function () {
      $("#trello_hover").css("display", "block");
    },
    function () {
      $("#trello_hover").css("display", "none");
    }
  );

  $(".btn.habit").click(function (e) {
    e.preventDefault();
    $("#checkin_text").wrapSelectedText("<habit>", "</habit>", true);
  });

  $(".insertText").click(function (e) {
    e.preventDefault();
    $this = $(this);
    var cursor = $("#checkin_text").getSelectionStart();
    var text = $this.text();
    var len = text.length;
    console.log(cursor);
    console.log(text);
    console.log(len);

    $("#checkin_text").insertText(text, cursor, len, true);
  });

  $('.edit').editable('/status/gmail',
    {
      id:'key',
      name:'value'
    }
  );

  setMessage();
  updateTime();
});


