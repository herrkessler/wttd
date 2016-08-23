$(document).ready(function(){

  var route = window.location.pathname.replace('/', '');

  if (sessionStorage.length > 0) {
    $('body').data('located', '1');
  }

  if ($('body').hasClass('logged-in') && $('body').data('located') !== '0') {
    getLocation();
  }

  if ($('body').hasClass('logged-in') && route == 'venues') {
    calcDistances();
  }

  if ($('body').hasClass('logged-in') && $('#venue-profile').length > 0) {
    calcDistance();
  }

});


function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(setPosition);
  } else {
    console.log('No geolocation');
  }
}

function setPosition(position) {
  var userLat = position.coords.latitude,
      userLng = position.coords.longitude;

  sessionStorage.setItem('lat', userLat);
  sessionStorage.setItem('lng', userLng);

}

function calcDistances() {
  var venues = document.getElementsByClassName("venue"),
      userLat = sessionStorage.getItem('lat'),
      userLng = sessionStorage.getItem('lng');

  for (var i = 0, len = venues.length; i < len; i++) {
    var venueLat = venues[i].dataset.lat,
        venueLng = venues[i].dataset.lng,
        distance = getDistanceFromLatLonInKm(venueLat,venueLng,userLat,userLng),
        distanceWrapper = venues[i].querySelector('.js-calculated-distance');

    distanceWrapper.innerHTML = parseInt(distance) + 'km';
  }
}

function calcDistance() {
  var venue = document.getElementById("venue-profile"),
      userLat = sessionStorage.getItem('lat'),
      userLng = sessionStorage.getItem('lng'),
      venueLat = venue.dataset.lat,
      venueLng = venue.dataset.lng,
      distance = getDistanceFromLatLonInKm(venueLat,venueLng,userLat,userLng),
      distanceWrapper = venue.querySelector('.js-calculated-distance');

  distanceWrapper.innerHTML = parseInt(distance) + 'km';
}