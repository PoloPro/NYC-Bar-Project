class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
  validates :user, presence: true
  validates :review, presence: true
  validate :one_like_per_user_per_review

  def one_like_per_user_per_review
    errors.add(:user_id, "You can't a like a review more than once!") if Like.any?{|l| l.user == user && l.review == review} && !id
  end
end
