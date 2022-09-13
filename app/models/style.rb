class Style < ApplicationRecord
  has_many :ratings, dependent: :destroy
end
