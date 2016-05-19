// $(document).ready(function(){
//   addedOutlines();
// })
//
//
//
//
//
// var map;
// // This function loads the map.
// // It is centered over the Flatiron School and has a boundry
// function initMap() {
//   map = new google.maps.Map(document.getElementById('map'), {
//     center: {lat: 40.705326, lng: -74.013942},
//     zoom: 15,
//     minZoom: 11
//   });
// var boundry = new google.maps.LatLngBounds(
//   new google.maps.LatLng(40.469, -74.315),
//   new google.maps.LatLng(40.950, -73.608)
// )
// var lastValidCenter = map.getCenter();
//
// google.maps.event.addListener(map, 'center_changed', function() {
//     if (boundry.contains(map.getCenter())) {
//         // still within valid bounds, so save the last valid position
//         lastValidCenter = map.getCenter();
//         return;
//     }
//
//     // not valid anymore => return to last valid position
//     map.panTo(lastValidCenter);
// });
// }
//
//
// // This function calls 5 AJAX requests to add neighborhood outlines
//
// var addedOutlines = function() {
// $.ajax({
//   dataType: "JSON",
//   url: "/manhattan/json",
//   success: function(response) {
//     map.data.addGeoJson(response)
//   }
// }).error(function(){
//   alert("shit it broke.")
// })
//
// $.ajax({
//   dataType: "JSON",
//   url: "/brooklyn/json",
//   success: function(response) {
//     map.data.addGeoJson(response)
//   }
// }).error(function(){
//   alert("shit it broke.")
// })
//
// $.ajax({
//   dataType: "JSON",
//   url: "/bronx/json",
//   success: function(response) {
//     map.data.addGeoJson(response)
//   }
// }).error(function(){
//   alert("shit it broke.")
// })
//
// $.ajax({
//   dataType: "JSON",
//   url: "/queens/json",
//   success: function(response) {
//     map.data.addGeoJson(response)
//   }
// }).error(function(){
//   alert("shit it broke.")
// })
//
// $.ajax({
//   dataType: "JSON",
//   url: "/statenisland/json",
//   success: function(response) {
//     map.data.addGeoJson(response)
//   }
// }).error(function(){
//   alert("shit it broke.")
// })
//
//
//
//
// }
