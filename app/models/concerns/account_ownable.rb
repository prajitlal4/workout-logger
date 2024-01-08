module AccountOwnable
  extend ActiveSupport::Concern

  included do
    belongs_to :account, optional: true
    default_scope { where(account: Current.account_or_raise!) }
  end
end
