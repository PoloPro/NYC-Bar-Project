class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :bar
  validates :user, presence: true
  validates :content, presence: true
  validates :rating, inclusion: {in: [1.0, 2.0, 3.0, 4.0, 5.0]}
end
