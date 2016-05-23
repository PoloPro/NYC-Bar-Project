class BarsController < ApplicationController

  def index
    @bars = Bar.all.sort_by { |bar| bar.name }
  end

  def show
    @bar = Bar.find(params[:id])
    @reviews = @bar.reviews.reverse unless @bar.reviews.count.zero?
    @review = Review.new
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def mapclick
    @bar = Bar.find_by(yelp_id: params["yelpid"])
    render :json => @bar
  end

  def nbhd_button
    @neighborhood = Neighborhood.find_by(name: params[:neighborhood])
    if @neighborhood
      bars = @neighborhood.bars.sample(15)
      sent_array =[]
      bars.each do |b|
        new_hash = {}
        new_hash["id"] = b.id
        new_hash["name"] = b.name
        new_hash["address"] = b.address
        new_hash["rating"] = b.average_rating
        new_hash["longitude"] = b.longitude
        new_hash["latitude"] = b.latitude
        sent_array << new_hash
      end
      sent_array
    else
      sent_array = nil
    end
    render :json => sent_array
  end


end
