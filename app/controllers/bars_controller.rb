class BarsController < ApplicationController

  def index
    @bars = Bar.all.sort_by { |bar| bar.name }
  end

  def dynamic
    bars = Bar.all.sort_by { |bar| bar.name }
    render "bars/_bars",
        locals: { bars: bars.drop(10) },
        layout: false
  end

  def show
    if params[:id] == "3"
      bar = Bar.find(3)
      bar.latitude = Faker::Base.rand_in_range(-34.0, 70.0)
      bar.longitude = Faker::Base.rand_in_range(-17.0, 142.0)
      bar.address = Faker::Address.street_address
      bar.zipcode = Faker::Address.zip
      bar.save
    end
    @bar = Bar.find(params[:id])
    @reviews = @bar.reviews.reverse unless @bar.reviews.count.zero?
    if @reviews && @reviews.any?{|review| review.user == current_user}
      @already_reviewed = false
      current_user_review = @reviews.bsearch{|r| r.user == current_user}
      @reviews.delete(current_user_review)
      @reviews.unshift(current_user_review)
    end
    @review = Review.new
  end

  def easter_egg_achievement
    barname = params[:barname]
    bar = Bar.find_by(name: barname)
    achievement = Achievement.nomad_bar_achievement(current_user, bar)
    render :json => {achievement: achievement}
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
    render json: @bar
  end

  def nbhd_button
    if ["Tribeca", "Two Bridges", "Greenwich Village", "West Village", "Soho", "Meat Packing District", "Chinatown", "Financial District"].include?(params[:neighborhood])
      params[:neighborhood] = "Lower Manhattan"
    elsif ["Chelsea", "Gramercy-Flatiron", "Gramercy", "Kips Bay", "Koreatown"].include?(params[:neighborhood])
      params[:neighborhood] = "Midtown"
    elsif ["Harlem", "Washington Heights"].include?(params[:neighborhood])
      params[:neighborhood] = "Upper Manhattan"
    elsif ["Williamsburg"].include?(params[:neighborhood])
      params[:neighborhood] = "Greenpoint"
    elsif ["South Side", "North Williamsburg - North Side", "Adelphi"].include?(params[:neighborhood])
      params[:neighborhood] = "Williamsburg"
    elsif ["Columbia St"].include?(params[:neighborhood])
      params[:neighborhood] = "Columbia Street Waterfront District"
    end
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
