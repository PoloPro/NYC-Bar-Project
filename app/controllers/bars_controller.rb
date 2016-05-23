class BarsController < ApplicationController

  def index
    @bars = Bar.all.sort_by { |bar| bar.name }
  end

  def show
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
