class Exercise < ApplicationRecord
  belongs_to :category
  belongs_to :exercise_type
  belongs_to :group
end
