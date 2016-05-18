class Bar < ActiveRecord::Base
  belongs_to :borough
  has_many :reviews
  has_many :users, through: :reviews
end
