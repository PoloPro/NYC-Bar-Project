module BarsHelper

  #run these methods in RAILS C



  # this method will reach out to Google
  # and assign a latitude and longitude to
  # all bars that do not have one

  def geolocate_all_bars
    Geocoder.configure({api_key: 'GOOGLE API KEY'})
    Bar.all.each do |bar|
      if bar.latitude == nil && bar.longitude == nil
        geo_hash = Geocoder.search(bar.address + ", " + bar.zipcode)
        bar.latitude = geo_hash[0].data["geometry"]["location"]["lat"]
        bar.longitude = geo_hash[0].data["geometry"]["location"]["lng"]
        bar.save
        sleep(0.2)
      end
    end
  end


# creates a file in the root
# once you move it to /app/geojson
# then it gets called in the ajax request that makes  the markers
  def create_bar_geojson
    marker_hash = { "type" => "geojson",
      "data" => {
        "type" => "FeatureCollection",
        "features" => []
      }
    }

      Bar.all.each do |single_bar|
        bar_hash = { "type" => "Feature",
                    "geometry" => {
                      "type" => "Point",
                      "coordinates" => []
                    },
                    "properties" => {
                      "title" => "",
                      "yelpid" => ""
                    }
                  }
        if single_bar.latitude == nil || single_bar.longitude == nil || single_bar.name == nil
        else
          bar_hash["properties"]["title"] = single_bar.name
          bar_hash["properties"]["yelpid"] = single_bar.yelp_id
          bar_hash["geometry"]["coordinates"] = [single_bar.longitude.to_f, single_bar.latitude.to_f]
          marker_hash["data"]["features"] << bar_hash
        end
      end
      File.open('marker_hash.geojson', 'w') { |file| file.write(marker_hash.to_json) }
  end

end
