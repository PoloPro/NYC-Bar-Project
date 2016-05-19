class YelpParser

  def initialize
    Yelp.client.configure do |config|
      config.consumer_key    = ENV["yelp_consumer_key"]
      config.consumer_secret = ENV["yelp_consumer_secret"]
      config.token           = ENV["yelp_token"]
      config.token_secret    = ENV["yelp_token_secret"]
    end
  end

  def bar_params(bar)
    {
      name: bar.name,
      address: bar.location.address[0],
      yelp_id: bar.id,
      yelp_rating: bar.rating,
      zipcode: bar.location.postal_code
    }
  end


  def zipcodes
    File.read("public/zipcodes.yml").split(", ")
  end


  def iterate_through_yelp
    zipcodes.each { |zipcode| yield(zipcode) }
  end

end

