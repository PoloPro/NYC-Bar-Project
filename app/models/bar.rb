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
      avg = (ratings.inject(:+) / ratings.count )
      # Round to nearest 0.5
      (avg * 2).round / 2.0
    else
      "No ratings yet!"
    end
  end

end
