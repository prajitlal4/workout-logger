class AddNotesToSessionExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :session_exercises, :note, :text
  end
end
