class AddGroupIdToTables < ActiveRecord::Migration[7.0]
  def change
    rename_column :exercises, :workspace_id, :group_id
    rename_column :group_members, :workspace_id, :group_id
    rename_column :categories, :workspace_id, :group_id
    rename_column :routines, :workspace_id, :group_id
  end
end
