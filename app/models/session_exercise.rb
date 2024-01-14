class SessionExercise < ApplicationRecord
  serialize :set_details, Array

  belongs_to :routine_exercise
  belongs_to :workout_session
  belongs_to :exercise
end
