class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :account

  class MissingCurrentAccount < StandardError; end

  def user=(user)
    super
    Rails.logger.debug("Current.account= #{user.account.inspect}")
    self.account = user.account

  end

  def account_or_raise!
    Rails.logger.debug("Current.account= #{Current.account.inspect}")
    raise Current::MissingCurrentAccount, "Account error" unless account

    account
  end

end
