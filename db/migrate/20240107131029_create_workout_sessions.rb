class CreateWorkoutSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_sessions do |t|
      t.references :workout_routine, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
