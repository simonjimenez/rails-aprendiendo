class Category < ApplicationRecord
  has_one_attached :photo
  has_many :stores
end
