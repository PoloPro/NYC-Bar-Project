class ReviewsController < ApplicationController


  def create
    @review = Review.new(review_params)
    if @review.valid?
      @review.save
    else
     render status: 400
    end
  end




private


def review_params
  params.require(:review).permit(:rating, :content, :user_id, :bar_id)
end

end
