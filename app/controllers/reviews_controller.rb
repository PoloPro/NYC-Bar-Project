class ReviewsController < ApplicationController

  before_filter :find_review, only: [:show, :edit, :update, :destroy]

  def create
    @review = Review.new(review_params)
    if @review.valid?
      @review.save
      @jsonresponse = {review: @review, user: @review.user}
      render json: @jsonresponse
    else
      render status: 400
    end
  end

  def edit
    redirect_to bar_path(@review.bar) if @review.user != current_user
  end

  def update
    if @review.update(review_params)
      redirect_to bar_path(@review.bar) 
    else
      render :edit, error: "Invalid review"
    end
  end

  def destroy
    @json = @review
    @review.destroy
    render json: @json
  end

private

def find_review
  @review = Review.find(params[:id])
end

def review_params
  params.require(:review).permit(:rating, :content, :user_id, :bar_id)
end

end
