class CreateGroupExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :group_exercises do |t|
      t.references :group, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
