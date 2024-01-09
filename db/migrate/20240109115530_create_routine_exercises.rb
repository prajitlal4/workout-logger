class CreateRoutineExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :routine_exercises do |t|
      t.string :name
      t.text :note
      t.integer :sets
      t.references :routine, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :exercise_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
