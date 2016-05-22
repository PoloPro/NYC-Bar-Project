
var mapgl;

//CREATE MAP
var initMapgl = function() {
//create toggle variable
  var toggle = false
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
          "text-font": ["Elementa Pro Bold"],
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
        "text-font": ["Elementa Pro Bold"],
        "text-offset": [0, 0.6],
        "text-anchor": "top"
      }
    })
  }
//creates our subway markers and removes included subway markers
  var createSubwayMarkers = function() {
      $.ajax({
        dataType: "JSON",
        url: '/subways/json'
      }).done(function(response){
        var geos = JSON.parse(response)
        mapgl.addSource("subways", geos)
        mapgl.removeLayer('rail-label')
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
        "text-font": ["Elementa Pro Bold"],
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
    $('#togglesubway').click(function(){
      if (toggle){
        removeSubwayMarkers();
        toggle = false
        $('#togglesubway').html("Toggle Subways ON")
      } else {
        addSubwayMarkers();
        toggle = true
        $('#togglesubway').html("Toggle Subways OFF")
      }
    })
  }
// after map fly-to, then grab subways and add popups
  var createPopup = function(e, features){
    var n = 150
    var box = [[e.point.x - n, e.point.y - n], [e.point.x + n, e.point.y + n]]
    var subs = mapgl.queryRenderedFeatures(box, { layers: ['subways'] }).splice(0,3);
    var neighborhood = mapgl.queryRenderedFeatures(e.point, { layers: ['36061','36047','36005','36081','36085'] })
    var neighborhoodLabel = neighborhood[0].properties.label
    var subwaylist = ""
    if (subs.length) {
      subwaylist += "<h5>Nearby Subways</h5>"

      var arrayBeforeUnique = []

      subs.forEach(function(station){
        arrayBeforeUnique.push('<p><strong>Station </strong>' + station.properties.name + "<strong>  |  Line(s): </strong>" + station.properties.line + '</p>')
      })

      function onlyUnique(value, index, self) {
          return self.indexOf(value) === index;
      }

      var uniqueArray = arrayBeforeUnique.filter(onlyUnique)

      uniqueArray.forEach(function(station){
        subwaylist += station
      })

    } else {
      subwaylist += "<h5>There are no subway stations nearby.</h5><h5>Or you have not added Subway markers onto the map.</h5>"
    }

    // console.log(subs)
    // console.log(features[0].properties.title);
    // console.log(features[0].properties.yelpid)
    $.ajax({
      type: "GET",
      url: '/bars/' + features[0].properties.yelpid + '/mapclick'
    }).done(function(response){
      var tooltip = new mapboxgl.Popup({closeOnClick: true})
        .setLngLat([response.longitude, response.latitude])
        .setHTML('<center><h5>' + response.name +'</h5><p>' + response.address + " | <strong>Neighborhood: </strong>" + neighborhoodLabel + '</p><hr>' + subwaylist + '</center>')
        .addTo(mapgl);
      // either create a popup on the map at the bar location
      // or drop down a card with the bar included
    })
  }
// on click function for map popups for bars
  mapgl.on('click', function(e) {
      var features = mapgl.queryRenderedFeatures(e.point, { radius: 25, layers: ['markers'] });
      if (features.length) {
        mapgl.flyTo({
          center: [e.lngLat.lng, e.lngLat.lat],
          zoom: 15
        })
        createPopup(e, features);
      }
    })
// adds markers when map loads
  mapgl.on("load", function(){
      createBarMarkers();
      createSubwayMarkers();
      addFlatironSchool();
      buttonListener();
    })
//change mouse from grab to point on mouseover bar markers
  mapgl.on('mousemove', function(e){
    var features = mapgl.queryRenderedFeatures(e.point, { layers: ['markers'] });
    mapgl.getCanvas().style.cursor = (features.length) ? 'pointer' : '';
  })
//new toggle
  $('#subwaytoggle').bootstrapToggle({
    off: "Subways Off",
    on: 'Subways On'
  })
  $('#subwaytoggle').change(function(){
    if (toggle){
      removeSubwayMarkers();
      toggle = false
      $('#togglesubway').html("Toggle Subways ON")
    } else {
      addSubwayMarkers();
      toggle = true
      $('#togglesubway').html("Toggle Subways OFF")
    }
    })

//create map when page loads
$(document).ready(function(){
  initMapgl();
})
