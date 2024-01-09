class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :bodyweight
      t.text :notes
      t.references :routine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
