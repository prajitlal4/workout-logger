class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_account

  private

  def set_current_account
    if user_signed_in?
      Current.account = current_user.account
    end
  end
end
