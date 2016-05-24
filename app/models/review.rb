class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :bar
  validates :bar_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
  validates :rating, inclusion: {in: [1.0, 2.0, 3.0, 4.0, 5.0]}
  validate :one_bar_review_per_user
  has_many :likes


  def one_bar_review_per_user
    errors.add(:user_id, "cannot write more than one review per bar") if Review.where(user: user, bar: bar).count > 0 && !id
  end
end
