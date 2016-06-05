class Board < ApplicationRecord
  has_many :categories,dependent: :destroy
end
