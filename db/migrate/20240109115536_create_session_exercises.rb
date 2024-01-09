class CreateSessionExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :session_exercises do |t|
      t.references :routine_exercise, null: false, foreign_key: true
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
