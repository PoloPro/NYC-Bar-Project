class BarCardPopulator

  attr_accessor :nbhd_name

  def initialize(nbhd_name)
    @nbhd_name = nbhd_name
  end

  def populate
    replace_neighborhood
    find_neighborhood ? get_bars(find_neighborhood) : nil
  end

  def replace_neighborhood
    @nbhd_name = neighborhood_hash[nbhd_name] if neighborhood_hash[nbhd_name]
  end

  def find_neighborhood
    Neighborhood.find_by(name: nbhd_name)
  end

  def get_bars(neighborhood, number = 15)
    bars = neighborhood.bars.sample(number)
    bars.map {|b| bar_json_creator(b)}
  end

  def bar_json_creator(bar)
    object_hash = {}
    object_hash["id"] = bar.id
    object_hash["name"] = bar.name
    object_hash["address"] = bar.address
    object_hash["rating"] = bar.average_rating
    object_hash["longitude"] = bar.longitude
    object_hash["latitude"] = bar.latitude
    object_hash
  end

  private

  def neighborhood_hash
    {
      "Tribeca": "Lower Manhattan", 
      "Two Bridges": "Lower Manhattan", 
      "Greenwich Village": "Lower Manhattan", 
      "West Village": "Lower Manhattan", 
      "Soho": "Lower Manhattan", 
      "Meat Packing District": "Lower Manhattan", 
      "Chinatown": "Lower Manhattan", 
      "Financial District": "Lower Manhattan", 
      "Chelsea": "Midtown", 
      "Gramercy-Flatiron": "Midtown", 
      "Gramercy": "Midtown", 
      "Kips Bay": "Midtown", 
      "Koreatown": "Midtown", 
      "Harlem": "Upper Manhattan", 
      "Washington Heights": "Upper Manhattan", 
      "Williamsburg": "Greenpoint",
      "South Side": "Williamsburg",
      "North Williamsburg - North Side": "Williamsburg",
      "Adelphi": "Williamsburg",
      "Columbia St": "Columbia Street Waterfront District"
    }
    end

  end