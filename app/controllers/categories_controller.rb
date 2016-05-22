class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @categories = Category.all.sort_by { |category| -category.bars.count }
  end

  def show
    @category = Category.find(params[:id])
  end
end
