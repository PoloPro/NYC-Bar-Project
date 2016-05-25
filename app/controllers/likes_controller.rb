class LikesController < ApplicationController

  def create
    @like = Like.create(review_id: params[:review_id], user: current_user)
    render json: {like: @like, like_message: @like.review.like_message(current_user), status: 'liked'}
  end

  def destroy
    @like = Like.find(params[:id])
    @unliked_like = @like
    @like.destroy
    render json: {like: @unliked_like, like_message: @unliked_like.review.like_message(current_user), status: 'unliked'}
  end
end