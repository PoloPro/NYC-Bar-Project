var map;
var mapgl;
var ajaxRequest;
var plotlist;
var plotlayers=[];

var initMapgl = function() {
  var southWest = new mapboxgl.LngLat(-74.549, 40.261)
  var northEast = new mapboxgl.LngLat(-73.331, 41.062)
  var bounds = new mapboxgl.LngLatBounds(southWest, northEast)
  mapboxgl.accessToken = 'pk.eyJ1IjoicmhvcHJoaCIsImEiOiJjaW9mN3J3OGYwMHN5eThtMnJ3enF0aHU4In0.cNczHe5-6C2mHIR5ivaKOw'

  var mapgl = new mapboxgl.Map({
      container: 'mapgl',
      minZoom: 9,
      maxZoom: 18,
      bearing: 29,
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

mapgl.on('click', function(e) {
    var features = mapgl.queryRenderedFeatures(e.point, { radius: 10, layers: ['markers'] });
    console.log(features[0].properties.title);

      // mapgl.featuresAt(e.point, {radius: 1000, layer: 'markers', includeGeometry: true}, function(err, features) {
      //       console.log(features[0]);
      //
      // });

    });

  mapgl.on("load", function(){
    createMarkers();
    addFlatironSchool();
  })
};


$(document).ready(function(){
  initMapgl();
});
