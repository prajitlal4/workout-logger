class WorkoutSession < ApplicationRecord
  belongs_to :workout_routine
  belongs_to :user
  belongs_to :workspace
  has_many :workout_exercises
end
