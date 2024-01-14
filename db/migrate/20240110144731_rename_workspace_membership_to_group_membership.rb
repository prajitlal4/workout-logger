class RenameWorkspaceMembershipToGroupMembership < ActiveRecord::Migration[7.0]
  def change
    rename_table :workspace_members, :group_members
  end
end
