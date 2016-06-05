class Category < ApplicationRecord
  belongs_to :board
  has_many :sites,dependent: :destroy
end
