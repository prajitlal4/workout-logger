class AddForeignKeysToWorkoutSessions < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :workout_sessions, :routines, column: :routine_id
    add_foreign_key :workout_sessions, :users, column: :user_id
    add_foreign_key :workout_sessions, :groups, column: :group_id
  end
end
