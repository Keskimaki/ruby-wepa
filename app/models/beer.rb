class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    return 0 if ratings.empty?

    score = 0
    ratings.each do |rating|
      score += rating.score
    end

    return score / ratings.count
  end
end
