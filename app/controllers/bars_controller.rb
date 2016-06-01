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
    @bar = Bar.find(params[:id])
    NomadBarRelocator.relocate(@bar) if @bar.name == "The NoMad Bar"
    @classifier = BarReviewClassifier.new(@bar.reviews, current_user) if @bar.reviews
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
    bars = BarCardPopulator.new(params[:neighborhood]).populate
    render :json => bars
  end


end
