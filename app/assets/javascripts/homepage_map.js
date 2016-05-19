// var initMap = function(){
//   var mymap = L.map('map', {
//     center: [40.705326, -74.013942],
//     zoom: 15
//   });
//
//   var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
// 	var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
// 	var osm = new L.TileLayer(osmUrl, {minZoom: 8, maxZoom: 12, attribution: osmAttrib});
//   map.addLayer(osm);
// }
// initMap();


var map;
var mapgl;
var ajaxRequest;
var plotlist;
var plotlayers=[];

var initMapLeaflet = function() {


  // set map boundary
  var southWest = L.latLng(40.469, -74.315)
  var northEast = L.latLng(40.950, -73.608)
  var bounds = L.latLngBounds(southWest, northEast)
	// set up the map and add it
  L.mapbox.accessToken = ENV['mapbox_token']
	var map = L.mapbox.map('map', 'mapbox.streets', {
    maxBounds: bounds,
    minZoom: 10,
    maxZoom: 19
  }).setView([40.705326, -74.013942], 14);

  // add the "tileset" which includes the neighborhood overlays
  L.tileLayer('https://api.mapbox.com/styles/v1/rhoprhh/cioegtr6d0011ainlkhuy28e8/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoicmhvcHJoaCIsImEiOiJjaW9lZDNuY3cwMGttdGJrbWNvbmN2dmRzIn0.Xwkl6WY8C08DSX0stSBWQg').addTo(map);
  // L.marker([40.761367, -73.819466]).bindLabel('Flushing').addTo(map);

}

var initMapgl = function() {
  var southWest = new mapboxgl.LngLat(-74.549, 40.261)
  var northEast = new mapboxgl.LngLat(-73.331, 41.062)
  var bounds = new mapboxgl.LngLatBounds(southWest, northEast)
  mapboxgl.accessToken = 'pk.eyJ1IjoicmhvcHJoaCIsImEiOiJjaW9lbmxtNHgwMG82dTdrbTlwZm16em9xIn0.WmtA4_OZaMM-gmlaRTMPWA'

  var mapgl = new mapboxgl.Map({
      container: 'mapgl',
      minZoom: 9,
      maxZoom: 18,
      bearing: 30,
      center: [-74.013942, 40.705326],
      zoom: 13,
      maxBounds: bounds,
      style: 'mapbox://styles/rhoprhh/cioegtr6d0011ainlkhuy28e8'
  });


  var createMarkers = function() {
    $.ajax({
      dataType: "JSON",
      url: '/markers/json'
    }).done(function(response){
      var geo = JSON.parse(response)
      mapgl.addSource("markers", geo)
      mapgl.addLayer({
        "id": "markers",
        "type": "symbol",
        "source": "markers",
        "layout": {
          "icon-image": "bar-15",
          "text-field": "{title}",
          "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
          "text-offset": [0, 0.6],
          "text-anchor": "top"
        }

      })
    })
  }

  var addFlatironSchool = function() {
    mapgl.addSource("flatironschool",
      { "type": "geojson",
        "data": {
          "type": "FeatureCollection",
          "features": [{ "type": "Feature",
                      "geometry": {
                        "type": "Point",
                        "coordinates": [-74.013908,40.705305]
                      },
                      "properties": {
                        "title": "Flatiron School"
                      }}]
        }
      })

    mapgl.addLayer({
      "id": "flatironschool",
      "type": "symbol",
      "source": "flatironschool",
      "layout": {
        "icon-image": "school-15",
        "text-field": "{title}",
        "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
        "text-offset": [0, 0.6],
        "text-anchor": "top"
    }
  })
}


  mapgl.on("load", function(){
    createMarkers();
    addFlatironSchool();
  })
};




// var cleek = function(){
//   var tooltip = new mapboxgl.Popup()
//   .setLngLat([-73.819466, 40.761367])
//   .setHTML('<h5>flushing</h5>')
//   .addTo(mapgl);
// }
// cleek();




$(document).ready(function(){
  //initMapLeaflet();
  initMapgl();
});
