class LikesController < ApplicationController

  def create
    @like = Like.create(review_id: params[:review_id], user: current_user)
    redirect_to bar_path(@like.review.bar)
  end

  def destroy
    @like = Like.find(params[:id])
    @bar = @like.review.bar
    @like.destroy
    redirect_to bar_path(@bar)
  end
end