class WorkoutRoutine < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
  has_many :workout_sessions
end
