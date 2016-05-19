class Bar < ActiveRecord::Base
  belongs_to :borough
  has_many :reviews
  has_many :users, through: :reviews
  has_and_belongs_to_many :categories, -> { uniq }

  validates :address, presence: true
  validates :name, uniqueness: true

  def average_rating
    total_rating = 0;
    Bar.reviews.map { |review| total_rating += review.rating }
    total_rating / reviews.count
  end

end
