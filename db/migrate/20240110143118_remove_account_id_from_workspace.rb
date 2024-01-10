class RemoveAccountIdFromWorkspace < ActiveRecord::Migration[7.0]
  def change
    remove_column :workspaces, :account_id, :integer
  end
end
