class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    ratings.empty? ? 0 : ratings.average(:score).round(2)
  end

  def to_s
    "#{name} #{brewery.name}"
  end
end
