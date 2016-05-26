class Achievement < ActiveRecord::Base
  has_many :user_achievements
  has_many :users, through: :user_achievements

  def self.facebook_auth(user)
    if user.provider == "facebook"
      user.achievements << Achievement.find_by(name: "The Social Network")
      user.save
    end
  end

  def self.first_review(user)
    if user.reviews.count > 0 && !user.achievements.include?(Achievement.find_by(name: "Just Getting Started"))
      new_achievement = Achievement.find_by(name: "Just Getting Started")
      user.achievements << new_achievement
      user.save
      new_achievement
    else
      nil
    end
  end

  def self.nomad_bar_achievement(user, bar)
    achievement = Achievement.find_by(name: "Globetrotter")
    if bar == Bar.find_by(name: "The NoMad Bar") && !user.achievements.include?(achievement)
      user.achievements << achievement
      user.save
      achievement
    else
      nil
    end
  end

  def self.like_review_achievement(like)
    achievement = Achievement.find_by(name: "Cheers")
    if like.user.likes.count == 1 && like.review.user != like.user && !like.user.achievements.include?(achievement)
      like.user.achievements << achievement
      like.user.save
      achievement.save
      achievement
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
    if array.count == 5 && !user.achievements.include?(Achievement.find_by(name: "Island Hopping"))
      new_achievement = Achievement.find_by(name: "Island Hopping")
      user.achievements << new_achievement
      user.save
      return new_achievement
    else
      nil
    end
  end

  def self.review_liked_achievement(like)
    achievement = Achievement.find_by(name: "Pulitzer")
    if like.review.user.reviews.map{|r| r.likes.count}.inject(0, :+) == 1 && like.review.user != like.user && !like.review.user.achievements.include?(achievement)
      like.review.user.achievements << achievement; like.review.user.save; achievement.save
      achievement
    else
      nil
    end
  end

  def self.five_reviews_in_one_borough(user)
    new_achievement = Achievement.find_by(name: "Pentakill")
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
    achievement3 = self.five_reviews_in_one_borough(user)
    achievement = achievement3 if achievement3 != nil
    return achievement
  end

  def self.new_like_achievements(like)
    review_liked_achievement(like)
    like_review_achievement(like)
  end

  def self.get_follow_achievement(follow)
    achievement = Achievement.find_by(name: "Fame and Fortune")
    if follow.followable.followers.count == 1 && !follow.followable.achievements.include?(achievement)
      follow.followable.achievements << achievement; follow.followable.save; achievement.save
      achievement
    else
      nil
    end
  end

  def self.follow_user_achievement(user)
    achievement = Achievement.find_by(name: "Follow the Crowd")
    if user.follows.count > 0 && !user.achievements.include?(achievement)
      user.achievements << achievement
      user.save
      achievement
    else
      nil
    end
  end

  def self.new_follow_achievements(follow)
    get_follow_achievement(follow)
    follow_user_achievement(follow)
  end
end
