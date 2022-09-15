class Style < ApplicationRecord
  has_many :beers

  def average_rating
    return 0 if beers.empty?

    beer_ratings = beers.map(&:average_rating).select { |score| score > 0 }

    return 0 if beer_ratings.empty?

    beer_ratings.sum / beer_ratings.count.to_f
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.average_rating || 0) }
    sorted_by_rating_in_desc_order.take(n)
  end
end
