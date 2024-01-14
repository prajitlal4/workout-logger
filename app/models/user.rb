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
    user = User.find_by(email: attributes[:email])

    if user
      group = Group.find(attributes[:group_id])
      unless GroupMember.exists?(user: user, group: group)
        GroupMember.create(user: user, group: group)
      end
    else
      super
    end
  end
end
