class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates :password, length: { minimum: 4 },
                       format: { with: /\A[A-Z].*\d|\d.*[A-Z]\z/, message: "must include one upper case letter and number" }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    beers.group(:style).average(:score).max_by { |_, v| v }.first.name
  end

  def favorite_brewery
    return nil if ratings.empty?

    beers.group(:brewery).average(:score).max_by { |_, v| v }.first
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |b| -(b.ratings.count || 0) }
    sorted_by_rating_in_desc_order.take(n)
  end
end
