class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    drop_table :exercises if table_exists?(:exercises)

    create_table :exercises do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.references :exercise_type, null: false, foreign_key: true
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
