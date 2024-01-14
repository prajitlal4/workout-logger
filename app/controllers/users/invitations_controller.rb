class Users::InvitationsController < Devise::InvitationsController
  def update
    super do |resource|
      if resource.errors.empty?
        association = InvitationGroupAssociation.find_by(invitation_token: resource.invitation_token)
        if association
          association.group.group_members.create(user: resource) unless association.group.group_members.exists?(user: resource)
          association.destroy
        end
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
end
