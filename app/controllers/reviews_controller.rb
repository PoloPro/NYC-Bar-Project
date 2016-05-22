class ReviewsController < ApplicationController


  def create
    @review = Review.new(review_params)
    if @review.valid?
      @review.save
      render json: @review
    else
      render status: 400
    end
  end

  def edit
    find_review
    redirect_to bar_path(@review.bar) if @review.user != current_user
  end

  def update
    find_review
    if @review.update(review_params)
      redirect_to bar_path(@review.bar) 
    else
      render :edit, alert: "Invalid review"
    end
  end

  def destroy
    find_review
  end




private

def find_review
  @review = Review.find(params[:id])
end

def review_params
  params.require(:review).permit(:rating, :content, :user_id, :bar_id)
end

end
