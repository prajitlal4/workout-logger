class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :account

  class MissingCurrentAccount < StandardError; end

  def user=(user)
    super
    self.account = user&.account

  end

  def account_or_raise!
    raise Current::MissingCurrentAccount, "Account error" unless account

    account
  end

end
