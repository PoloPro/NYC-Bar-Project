class Bar < ActiveRecord::Base
  belongs_to :borough
  has_many :reviews
  has_many :users, through: :reviews
  has_and_belongs_to_many :categories, -> { uniq }

  validates :address, presence: true
  validates :name, uniqueness: true

  def average_rating
    if reviews.count > 0
      ratings = reviews.map {|review| review.rating}.compact
      ratings.inject(:+) / ratings.count
    else
      "No ratings yet!"
    end
  end

end
