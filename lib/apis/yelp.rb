require_relative '../../config/environment.rb'





Yelp.client.configure do |config|
  config.consumer_key = ENV["yelp_consumer_key"]
  config.consumer_secret = ENV["yelp_consumer_secret"]
  config.token = ENV["yelp_token"]
  config.token_secret = ENV["yelp_token_secret"]
end

params = {category_filter: 'bars'}
@zipcodes = File.read("public/zipcodes.yml")


binding.pry




#categories, id, location, name, rating, 

business_array = Array.new

def iterateThroughYelp)
  @zipcodes.each do |zipcode|

    business_array << Yelp.client.search(zipcode, params).businesses
  end

end


