class Bar < ActiveRecord::Base
  belongs_to :neighborhood
  has_many :reviews
  has_many :users, through: :reviews
  has_and_belongs_to_many :categories, -> { uniq }

  validates :address, presence: true
  validates :yelp_id, uniqueness: true

  def average_rating
    if reviews.count > 0
      ratings = reviews.map { |review| review.rating }.compact
      ratings.inject(:+) / ratings.count
    else
      "No ratings yet!"
    end
  end

  def rounded_average_rating
    reviews.count > 0 ? (average_rating * 2).round / 2.0 : "No ratings yet!"
  end

  def self.random_interior_image
    images = [
      "https://media.timeout.com/images/100519023/image.jpg",
      "https://greenvalleyranch.sclv.com/~/media/Images/Page-Background-Images/GVR/Entertainment/GV_Entertainment_LobbyBar_01new.jpg?h=630&la=en&w=1080",
      "http://www.delkwoodgrill.net/wp-content/uploads/2016/01/SetWidth1700-Kempinski-Hotel-Bristol-Berlin-Gastronomie-Bristol-Bar.jpg",
      "http://www.delkwoodgrill.net/wp-content/uploads/2016/01/bar-02.jpg",
      "http://www.brusselspictures.com/wp-content/photos/DrugOpera1/drug.opera.1st.floor.bar.JPG",
      "http://philly.thedrinknation.com/images/bars/ristorantepanoramaphilly.jpg",
      "https://upload.wikimedia.org/wikipedia/commons/4/43/Bar-P1030319.jpg",
      "http://esq.h-cdn.co/assets/cm/15/06/640x320/54d3cdbba4f40_-_esq-01-bar-lgn.jpg",
      "http://i.huffpost.com/gen/1483434/images/o-BAR-facebook.jpg",
      "http://images.teamsugar.com/files/upl1/1/17470/34_2008/art_divebar_01.preview.jpg",
      "http://jackmovemag.com/wordpress/wordpress/wp-content/uploads/2011/09/Dive-Bar.jpg",
      "http://images.huffingtonpost.com/2014-01-22-tiki3.jpg" 
    ]

    images.sample
  end

end
