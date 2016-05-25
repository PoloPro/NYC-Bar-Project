class Achievement < ActiveRecord::Base
  has_many :user_achievements
  has_many :users, through: :user_achievements


  # def self.first_review(user)
  #   if user.reviews.count == 1 && !user.achievements.include?(Achievement.find_by(name: "First Review!"))
  #     user.achievements << Achievement.find_by(name: "First Review!")
  #     Achievement.find_by(name: "First Review!")
  #   end
  # end
  #
  # def self.review_in_all_boroughs(user)
  #   array = []
  #   me.reviews.each do |review|
  #     array << review.bar.neighborhood.borough
  #   end
  #   array.compact!
  #   if array.uniq!.count == 5 && !user.acheivements.include?(Achievement.find_by(name: "All 5 Boroughs"))
  #     user.achievements << Achievement.find_by(name: "All 5 Boroughs")
  #     Achievement.find_by(name: "All 5 Boroughs")
  #   else
  #     nil
  #   end
  # end
  #
  # def self.new_review_achievements(user)
  #   array = []
  #   array << self.first_review(user)
  #   array << self.review_in_all_boroughs(user)
  #   array.compact!
  # end

end
