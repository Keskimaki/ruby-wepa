class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    ratings.empty? ? 0 : ratings.average(:score).round(2)
  end
end
