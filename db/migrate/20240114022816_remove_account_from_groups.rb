class RemoveAccountFromGroups < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :account_id
  end
end
