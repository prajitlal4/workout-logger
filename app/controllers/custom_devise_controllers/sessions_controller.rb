# frozen_string_literal: true

class CustomDeviseControllers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super do |user|
      Rails.logger.debug("user= #{user.inspect}")
      Current.user = user
      Current.account = user.account
      Rails.logger.debug("Current.user= #{Current.user.inspect}")
      Rails.logger.debug("Current.account= #{Current.account.inspect}")
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
