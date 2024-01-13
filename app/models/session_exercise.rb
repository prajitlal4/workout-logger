class SessionExercise < ApplicationRecord
  serialize :set_details, Array

  belongs_to :routine_exercise
  belongs_to :session
  belongs_to :exercise
end
