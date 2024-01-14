class AddStartDateAndEndDateToWorkoutSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :workout_sessions, :start_time, :datetime
    add_column :workout_sessions, :end_time, :datetime
  end
end
