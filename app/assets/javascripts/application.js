//= require jquery
//= require jquery_ujs
//= require jquery.jeditable.mini
//= require jquery.textSelection-1.0
//= require Selection-1.0
//= require jquery.autosize
//= require strftime-1.3
//= require bootstrap

// Helper Methods

// set the 25 minute times
function setAlertMessage() {
  var minutes = 25;
  setTimeout("alertMessage()", 60000 * minutes);
}

function alertMessage() {
  alert("Nag.");
}

function updateTime() {
  var d = new Date;
  $("#timer").text(d.strftime("%I:%M %P"));
}

function geocode() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;
      var accuracy = position.coords.accuracy;

      $("#checkin_latitude").attr('value', latitude);
      $("#checkin_longitude").attr('value', longitude);

      var output = document.getElementById("map-image");
      var img = new Image();
      img.src = "http://maps.googleapis.com/maps/api/staticmap?center=" + latitude + "," + longitude + "&sensor=false&markers=color:green%7Clabel:here%7C" + latitude + "," + longitude + "&size=300x300&zoom=15";
      output.appendChild(img);

    }, function error(msg) {
      alert('Please enable your GPS position future.');
    }, { maximumAge: 600000, timeout: 5000, enableHighAccuracy: false });
  } else {
    alert("Geolocation API is not supported in your browser.");
  }
}

// On Start
$(function () {
  $('textarea').autosize();

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

  setAlertMessage();
  updateTime();
  geocode();
});
