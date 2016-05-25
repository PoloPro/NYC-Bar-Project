class Achievement < ActiveRecord::Base
  has_many :user_achievements
  has_many :users, through: :user_achievements


  def self.nomad_bar_achievement(user, bar)
    achievement = Achievement.find_by(name: "Easter Egg Bar")
    if bar == Bar.find_by(name: "The NoMad Bar") && !user.achievements.include?(achievement)
      user.achievements << achievement
      user.save; achievement.save
      achievement.name
    else
      nil
    end
  end

  def self.like_review_achievement(like)
    achievement = Achievement.find_by(name: "Like a Review") 
    if like.user.likes.count == 1 && like.review.user != like.user && !like.user.achievements.include?(achievement)
      like.user.achievements << achievement; like.user.save; achievement.save
      achievement
    else
      nil
    end
  end

  def self.review_liked_achievement(like)
    achievement = Achievement.find_by(name: "Get Your Review Liked")
    if like.review.user.reviews.map{|r| r.likes}.count == 1 && like.review.user != like.user && !like.review.user.achievements.include?(achievement)
      like.review.user.achievements << achievement; like.review.user.save; achievement.save
      achievement
    else
      nil
    end
  end
  def self.new_like_achievements(like)
    review_liked_achievement(like) 
    like_review_achievement(like)
  end

  def self.get_follow_achievement(follow)
    achievement = Achievement.find_by(name: "Get a Follow")
     if follow.followable.followers == 1 && !follow.followable.achievements.include?(achievement)
      follow.followable.achievements << achievement; follow.followable.save; achievement.save
      achievement
    else
      nil
    end 
  end

  def self.follow_user_achievement(follow)
    achievement = Achievement.find_by(name: "Follow a User")
    if follow.follower.all_following.count == 1 && !follow.follower.achievements.include?(achievement)
      follow.follower.achievements << achievement; follow.follower.save; achievement.save
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