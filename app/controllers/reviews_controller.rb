class ReviewsController < ApplicationController


  def create
    @review = Review.new(review_params)
    flash[:notice] = "Your rating must be an integer between 1 and 5" if !@review.save
    redirect_to bar_path(@review.bar)
  end




private


def review_params
  params.require(:review).permit(:rating, :content, :user_id, :bar_id)
end

end
