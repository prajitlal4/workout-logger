class AddAccountIdToWorkspaces < ActiveRecord::Migration[7.0]
  def change
    add_reference :workspaces, :account, null: true, foreign_key: true
  end
end
