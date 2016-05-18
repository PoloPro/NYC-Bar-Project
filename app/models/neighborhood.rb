class Neighborhood < ActiveRecord::Base
  belongs_to :borough
  has_many :bars
end
