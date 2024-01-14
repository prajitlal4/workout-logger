class RenameWorkoutSessionsOnTables < ActiveRecord::Migration[7.0]
  def change
    rename_column :workout_sessions, :workout_routine_id, :routine_id
    rename_column :workout_sessions, :workspace_id, :group_id
  end
end
