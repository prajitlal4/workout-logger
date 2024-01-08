class RemoveAccountIdFromWorkspace < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :workspaces, :accounts if foreign_key_exists?(:workspaces, :accounts)
    remove_column :workspaces, :account_id
  end
end
