class Exercise < ApplicationRecord
  belongs_to :category
  belongs_to :exercise_type
  belongs_to :user, optional: true

  has_many :group_exercises
  has_many :groups, through: :group_exercises
end
