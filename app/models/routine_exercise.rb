class RoutineExercise < ApplicationRecord
  has_many :session_exercises, dependent: :destroy
  belongs_to :routine
  belongs_to :exercise
end
