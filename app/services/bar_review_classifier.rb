class BarReviewClassifier

  attr_reader :reviews
  attr_reader :current_user
  
  def initialize(reviews, current_user)
    @reviews = sort_by_likes(reviews)
    @current_user = current_user
  end

  def sort_by_likes(reviews)
    reviews.sort_by{|r| -r.likes.count}
  end

  def user_review
    reviews.find{ |r| r.user == current_user }
  end

  def reviews_from_following
    reviews.select{|r| current_user.following?(r.user)} 
  end

  def reviews_from_nonfollowing
    reviews.reject{|r| reviews_from_following.include?(r) || user_review == r}
  end

end