class RoutineExercise < ApplicationRecord
  belongs_to :routine
  belongs_to :category
  belongs_to :exercise_type
end
