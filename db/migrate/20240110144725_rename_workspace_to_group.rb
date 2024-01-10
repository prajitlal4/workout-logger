class RenameWorkspaceToGroup < ActiveRecord::Migration[7.0]
  def change
    rename_table :workspaces, :groups
  end
end
