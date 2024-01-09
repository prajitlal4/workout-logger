module AccountOwnable
  extend ActiveSupport::Concern

  included do
    belongs_to :account, optional: true

    # Shows workspaces which are created by the account
    scope :owned_by_current_account, -> { where(account_id: Current.account) }

    # Shows workspaces which the user is a member of, but not the owner of
    scope :membership_except_owned, -> (user_id) {
    joins(:workspace_members)
      .where(workspace_members: { user_id: user_id })
      .where.not(account_id: Current.account)
    }
  end
end
