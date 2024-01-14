class CreateInvitationGroupAssociations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitation_group_associations do |t|
      t.string :email
      t.references :group, null: false, foreign_key: true
      t.string :invitation_token

      t.timestamps
    end
  end
end
