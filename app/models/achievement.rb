class Achievement < ActiveRecord::Base
  has_many :user_achievements
  has_many :users, through: :user_achievements

  def self.facebook_auth(user)
    if user.provider == "facebook"
      user.achievements << Achievement.find_by(name: "Facebook Integration")
      user.save
    end
  end

  def self.first_review(user)
    if user.reviews.count > 0 && !user.achievements.include?(Achievement.find_by(name: "First Review!"))
      new_achievement = Achievement.find_by(name: "First Review!")
      user.achievements << new_achievement
      user.save
      new_achievement
    else
      nil
    end
  end

  def self.review_in_all_boroughs(user)
    array = user.reviews.map do |review|
      review.bar.neighborhood.borough
    end
    array.compact!
    array.uniq!
    if array.count == 5 && !user.achievements.include?(Achievement.find_by(name: "All 5 Boroughs"))
      new_achievement = Achievement.find_by(name: "All 5 Boroughs")
      user.achievements << new_achievement
      user.save
      return new_achievement
    else
      nil
    end
  end

  def self.five_reviews_in_one_borough(user)
    new_achievement = Achievement.find_by(name: "5 in 1")
    if !user.achievements.include?(new_achievement)
      hash = {}
      bool = false
      user.reviews.each do |review|
        if review.bar.neighborhood.borough != nil
          if hash[review.bar.neighborhood.borough.name]
            hash[review.bar.neighborhood.borough.name] += 1
          else
            hash[review.bar.neighborhood.borough.name] = 1
          end
        end
      end
      hash.values.each do |value|
        if value > 4
          bool = true
        end
      end
      if bool == true
        user.achievements << new_achievement
        user.save
        return new_achievement
      end
    else
      nil
    end
  end

  def self.new_review_achievements(user)
    achievement = nil
    achievement = self.first_review(user)
    achievement2 = self.review_in_all_boroughs(user)
    achievement =  achievement2 if achievement2 != nil
    achivement3 = self.five_reviews_in_one_borough(user)
    achievement = achivement3 if achivement3 != nil
    binding.pry
    return achievement
  end

end
