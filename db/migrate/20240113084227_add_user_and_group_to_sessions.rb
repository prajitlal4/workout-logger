class AddUserAndGroupToSessions < ActiveRecord::Migration[7.0]
  def change
    add_reference :sessions, :user, null: false, foreign_key: true
    add_reference :sessions, :group, null: false, foreign_key: true
  end
end
