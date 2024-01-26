class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_members
  has_many :groups, through: :group_members
  has_many :routines
  has_many :workout_sessions
  has_many :exercises

  def self.invite!(attributes = {}, invited_by = nil)
    invited_user = super(attributes.except(:group_id), invited_by)
    user = User.find_by(email: invited_user.email)
    if user
      group = Group.find(attributes[:group_id])
      unless GroupMember.exists?(user: user, group: group)
        GroupMember.create(user: user, group: group)
      end
    else
      if invited_user.persisted? && attributes[:group_id]
        InvitationGroupAssociation.create!(
          email: invited_user.email,
          group_id: attributes[:group_id],
          invitation_token: invited_user.raw_invitation_token
        )
      end
    end
    invited_user
  end
end
