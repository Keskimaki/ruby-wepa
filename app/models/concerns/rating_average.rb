module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    rating_conut = ratings.size
    
    return 0 if rating_conut == 0
    ratings.map{ |r| r.score }.sum / rating_conut
  end
end
