class RemoveOldFkFromWorkoutSessions < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :workout_sessions, :workout_routines, column: :routine_id
  end
end
