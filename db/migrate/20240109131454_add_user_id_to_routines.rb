class AddUserIdToRoutines < ActiveRecord::Migration[7.0]
  def change
    add_reference :routines, :user, null: false, foreign_key: true
  end
end
