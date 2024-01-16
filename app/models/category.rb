class Category < ApplicationRecord
  has_many :exercises
  belongs_to :group
end
