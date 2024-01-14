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
    super(attributes.except(:group_id), invited_by) do |invitable|
      if attributes[:group_id]
        InvitationGroupAssociation.create!(
          email: attributes[:email],
          group_id: attributes[:group_id],
          invitation_token: invitable.raw_invitation_token
        )
    end
  end
end

end
