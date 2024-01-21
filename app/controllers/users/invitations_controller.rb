class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters
  def update
    raw_token = params[:user][:invitation_token]
    association = InvitationGroupAssociation.find_by(invitation_token: raw_token)

    super do |resource|
      if resource.errors.empty? && association
        association.group.group_members.create(user: resource) unless association.group.group_members.exists?(user: resource)
        association.destroy
      end
    end
  end

  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  private

  def resource_params
    params.require(:user).permit(:name, :password, :password_confirmation, :invitation_token)
  end

end
