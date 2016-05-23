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
    render json: @bar
  end

end
