class FixFkConstraintsinSessionExercises < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :session_exercises, :sessions
    add_foreign_key :session_exercises, :workout_sessions, column: :workout_session_id
    add_foreign_key :session_exercises, :routine_exercises, column: :routine_exercise_id
  end
end
