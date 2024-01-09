class CreateRoutines < ActiveRecord::Migration[7.0]
  def change
    create_table :routines do |t|
      t.string :name
      t.text :description
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
