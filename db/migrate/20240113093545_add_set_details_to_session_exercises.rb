class AddSetDetailsToSessionExercises < ActiveRecord::Migration[7.0]
  def change
    add_column :session_exercises, :set_details, :json
  end
end
