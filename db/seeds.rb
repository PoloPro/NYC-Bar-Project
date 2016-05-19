require_relative '../lib/apis/yelp.rb'

parser = YelpParser.new

first_pass_params = {
  category_filter: 'bars', 
  is_closed: false, 
  sort: 2
}

second_pass_params = {
  category_filter: 'bars', 
  is_closed: false, 
  sort: 2,
  offset: 20
}

zipcode_count = 0;
bar_count = 0;

# First pass through zipcodes, first 20 results, sorted by rating
parser.iterate_through_yelp do |zipcode| 
  zipcode_count += 1;

  Yelp.client.search(zipcode, first_pass_params).businesses.each do |bar|
    new_bar = Bar.find_or_create_by(parser.bar_params(bar))

    bar.categories.each do |category| 
      new_category = Category.find_or_create_by(name: category[0])
      new_bar.categories << new_category unless new_bar.categories.include?(new_category)
    end

    new_bar.save
    bar_count += 1;
  end

  puts "First pass: #{zipcode}"
end

# Second pass, next 20 results, sorted by rating
parser.iterate_through_yelp do |zipcode|

  Yelp.client.search(zipcode, second_pass_params).businesses.each do |bar|
    new_bar = Bar.find_or_create_by(parser.bar_params(bar))
    if bar.location.coordinate
      new_bar.lat = bar.location.coordinate.latitude
      new_bar.long = bar.location.coordinate.longitude
    end

    bar.categories.each do |category| 
      new_category = Category.find_or_create_by(name: category[0])
      new_bar.categories << new_category unless new_bar.categories.include?(new_category)
    end

    new_bar.save
    bar_count += 1;
  end

  puts "Second pass: #{zipcode}"
end

puts "#{bar_count} bars added to database in #{zipcode_count} zipcodes."
