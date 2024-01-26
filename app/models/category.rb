class Category < ApplicationRecord
  has_many :exercises
  belongs_to :user, optional: true
end
