class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :bar
  validates :user, presence: true, uniqueness: true
  validates :content, presence: true
  validates :rating, inclusion: {in: [1, 2, 3, 4, 5]}
end
