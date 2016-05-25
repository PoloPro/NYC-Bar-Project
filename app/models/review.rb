class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :bar
  validates :bar_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
  validates :rating, inclusion: {in: [1.0, 2.0, 3.0, 4.0, 5.0]}
  has_many :likes

  def liked_by?(current_user)
    likes.any? {|l| l.user == current_user}
  end

  def like_message(current_user)
    if !liked_by?(current_user) && likes.count > 2
      "#{likes.count} people like this."
    elsif !liked_by?(current_user) && likes.count == 1
      "1 person likes this."
    elsif likes.count > 2
      "You and #{likes.count} other people like this."
    elsif likes.count == 2
      "You and 1 other person likes this."
    elsif likes.count == 1
      "You like this."
    else
      "No one currently likes this."
    end
  end
end
