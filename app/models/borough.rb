class Borough < ActiveRecord::Base
  has_many :neighborhoods
  has_many :bars, through: :neighborhoods
end



