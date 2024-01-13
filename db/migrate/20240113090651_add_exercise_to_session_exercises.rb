class AddExerciseToSessionExercises < ActiveRecord::Migration[7.0]
  def change
    add_reference :session_exercises, :exercise, null: false, foreign_key: true
  end
end
