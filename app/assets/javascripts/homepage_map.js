
var mapgl;

//CREATE MAP
var initMapgl = function() {
//create map boundaries
  var southWest = new mapboxgl.LngLat(-74.549, 40.261)
  var northEast = new mapboxgl.LngLat(-73.331, 41.062)
  var bounds = new mapboxgl.LngLatBounds(southWest, northEast)
//access token
  mapboxgl.accessToken = 'pk.eyJ1IjoicmhvcHJoaCIsImEiOiJjaW9mN3J3OGYwMHN5eThtMnJ3enF0aHU4In0.cNczHe5-6C2mHIR5ivaKOw'
//instantiate the map
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


//CREATE AND ADD all Bars to map
  var createBarMarkers = function() {
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
//CREATE AND ADD flatiron school to map
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
//create subway markers
  var createSubwayMarkers = function() {
      $.ajax({
        dataType: "JSON",
        url: '/subways/json'
      }).done(function(response){
        var geos = JSON.parse(response)
        mapgl.addSource("subways", geos)
      })
    }
//add subways markers, called via button click
  var addSubwayMarkers = function() {
    mapgl.addLayer({
      "id": "subways",
      "type": "symbol",
      "source": "subways",
      "layout": {
        "icon-image": "new-york-subway",
        "text-field": "{name}",
        "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
        "text-offset": [0, 0.6],
        "text-anchor": "top"
      }
    })
  }
//remove subway markers, called via button click
  var removeSubwayMarkers = function() {
    mapgl.removeLayer("subways")
  }

//listen to add and remove button
  var buttonListener = function(){
    $('#addsubway').click(function(){
      addSubwayMarkers();
    })
    $('#removesubway').click(function(){
      removeSubwayMarkers();
    })
  }

// on click function for map popups for bars
mapgl.on('click', function(e) {
    var features = mapgl.queryRenderedFeatures(e.point, { radius: 25, layers: ['markers'] });
    if (features.length) {
      mapgl.flyTo({
        center: [e.lngLat.lng, e.lngLat.lat],
        zoom: 14
      })
    }
    var n = 70
    var box = [[e.point.x - n, e.point.y - n], [e.point.x + n, e.point.y + n]]
    var subways = mapgl.queryRenderedFeatures(box, { layers: ['subways'] });
    var subs = subways.splice(0,2)
    var subwaylist = "<ul>"
    subs.forEach(function(station){
      subwaylist += '<li>' + station.properties.name + " Station | Line(s): " + station.properties.line + '</li>'
    })
    subwaylist += '</ul>'
    // console.log(subs)
    // console.log(features[0].properties.title);
    // console.log(features[0].properties.yelpid)
    $.ajax({
      type: "GET",
      url: '/bars/' + features[0].properties.yelpid + '/mapclick'
    }).done(function(response){
      var tooltip = new mapboxgl.Popup({closeOnClick: true})
        .setLngLat([response.longitude, response.latitude])
        .setHTML('<center><h5>' + response.name +'</h5><p>' + response.address + '</p>' + subwaylist + '</center>')
        .addTo(mapgl);
      // either create a popup on the map at the bar location
      // or drop down a card with the bar included
    })
  })

// adds markers when map loads
mapgl.on("load", function(){
    createBarMarkers();
    createSubwayMarkers();
    addFlatironSchool();
    buttonListener();
  })
};



//create map when page loads
$(document).ready(function(){
  initMapgl();
});
