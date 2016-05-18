parser = YelpParser.new

parser.iterate_through_yelp do |zipcode| 
  Yelp.client.search(zipcode, parser.yelp_params).businesses.each do |bar|
    Bar.create(parser.bar_params(bar))
  end
end





