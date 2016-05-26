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
    @reviews = @bar.reviews.sort_by{|r| r.likes.count}.reverse.to_a unless @bar.reviews.count.zero?
    @user_review = @reviews.find{ |r| r.user == current_user } if @reviews
    @reviews_from_following = @reviews.to_a.delete_if{|r| !current_user.all_following.include?(r.user)} if @reviews
    @reviews_from_nonfollowing = @bar.reviews.sort_by{|r| r.likes.count}.to_a.delete_if{|r| @reviews_from_following.include?(r)} if @reviews
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
