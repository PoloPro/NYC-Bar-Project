module BarsHelper

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
                      "title" => ""
                    }
                  }
        if single_bar.lat == nil || single_bar.long == nil || single_bar.name == nil
        else
          bar_hash["properties"]["title"] = single_bar.name
          bar_hash["geometry"]["coordinates"] = [single_bar.long.to_f, single_bar.lat.to_f]
          marker_hash["data"]["features"] << bar_hash
        end
      end
      File.open('marker_hash.txt', 'w') { |file| file.write(marker_hash.to_json) }
  end

end
