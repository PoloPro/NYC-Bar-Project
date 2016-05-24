//More maps!
var initShowPageMap = function(lat, lng){

  //access token
    mapboxgl.accessToken = 'pk.eyJ1IjoicmhvcHJoaCIsImEiOiJjaW9mN3J3OGYwMHN5eThtMnJ3enF0aHU4In0.cNczHe5-6C2mHIR5ivaKOw'
  //instantiate map
    var barmap = new mapboxgl.Map({
      container: 'barmap',
      minZoom: 9,
      maxZoom: 19,
      bearing: 29,
      center: [lng, lat],
      zoom: 17,
      style: 'mapbox://styles/rhoprhh/cioegtr6d0011ainlkhuy28e8'
    });
  //create marker for the bar
    var createMarker = function(){
      var geo = {"type": "geojson","data": {"type": "FeatureCollection","features": [{"type": "Feature","geometry": {"type": "Point","coordinates": [$('#bar-lng').html(), $('#bar-lat').html()]},"properties": {"title": $('#bar-name').html() }}]}}
      barmap.addSource('barmarker', geo)
    }
  // add it to the map
    var addMarker = function(){
      barmap.addLayer({
        "id": "barmarker",
        "type": "symbol",
        "source": "barmarker",
        "layout": {
          "icon-image": "bar-15",
          "text-field": "{title}",
          "text-font": ["Elementa Pro Bold"],
          "text-offset": [0, 0.6],
          "text-anchor": "top"
        }
      })
    }
  // call the 2 above functions once the map loads
    barmap.on('load', function(){
      createMarker();
      addMarker();
    })

}

$(document).ready(function(){
  var lat = $('#bar-lat').html();
  var lng = $('#bar-lng').html();
  initShowPageMap(lat,lng);
})
