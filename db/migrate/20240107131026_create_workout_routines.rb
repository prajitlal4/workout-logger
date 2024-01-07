class CreateWorkoutRoutines < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_routines do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
