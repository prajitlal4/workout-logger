class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_members
  has_many :groups, through: :group_members
  has_many :routines
  has_many :workout_sessions

  def self.invite!(attributes = {}, invited_by = nil)
    invited_user = super(attributes.except(:group_id), invited_by)
    if invited_user.persisted? && attributes[:group_id]
      InvitationGroupAssociation.create!(
        email: invited_user.email,
        group_id: attributes[:group_id],
        invitation_token: invited_user.raw_invitation_token
      )
    end

    invited_user
  end
end
