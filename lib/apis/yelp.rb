require_relative '../../config/environment.rb'





Yelp.client.configure do |config|
  config.consumer_key = ENV["yelp_consumer_key"]
  config.consumer_secret = ENV["yelp_consumer_secret"]
  config.token = ENV["yelp_token"]
  config.token_secret = ENV["yelp_token_secret"]
end

params = {category_filter: 'bars', is_closed: false}
@zipcodes = File.read("public/zipcodes.yml")


binding.pry



business_array = Array.new
@zipcodes.each do |zipcode|
    business_array << Yelp.client.search(zipcode, params).businesses
end


