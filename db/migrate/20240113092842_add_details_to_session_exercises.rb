class AddDetailsToSessionExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :session_exercises, :sets, :integer
    add_column :session_exercises, :reps, :integer
    add_column :session_exercises, :weight, :decimal
  end
end
