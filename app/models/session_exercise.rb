class SessionExercise < ApplicationRecord
  belongs_to :routine_exercise
  belongs_to :session
  belongs_to :exercise
end
