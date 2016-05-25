class CategoriesController < ApplicationController

  def index
    @categories = Category.all.sort_by { |category| -category.bars.count }
  end

  def dynamic
    categories = Category.all.sort_by { |category| -category.bars.count }
    render "categories/_categories", 
        locals: { categories: categories.drop(20) },
        layout: false
  end

  def show
    @category = Category.find(params[:id])
  end
end
