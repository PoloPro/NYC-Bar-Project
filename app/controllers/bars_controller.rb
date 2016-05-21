class BarsController < ApplicationController

  def index
    @bars = Bar.all.sort_by{|bar| bar.name}
  end

  def show
    @bar = Bar.find(params[:id])
    @reviews = @bar.reviews.reverse unless @bar.reviews.count.zero?
    @review = @bar.reviews.build
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

end
