class RemoveForeignKeyFromSessionExercises < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :session_exercises, :routine_exercises
  end
end
