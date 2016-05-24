class Bar < ActiveRecord::Base
  belongs_to :neighborhood
  has_many :reviews
  has_many :users, through: :reviews
  has_and_belongs_to_many :categories, -> { uniq }

  validates :address, presence: true
  validates :yelp_id, uniqueness: true

  def average_rating
    if reviews.count > 0
      ratings = reviews.map { |review| review.rating }.compact
      ratings.inject(:+) / ratings.count
    else
      "No ratings yet!"
    end
  end

  def rounded_average_rating
    reviews.count > 0 ? (average_rating * 2).round / 2.0 : "No ratings yet!"
  end

end
