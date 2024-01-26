class Group < ApplicationRecord

  belongs_to :created_by_user, class_name: 'User'
  has_many :group_members
  has_many :users, through: :group_members
  has_many :routines
  has_many :workout_sessions

  has_many :invitation_group_associations

  has_many :group_exercises
  has_many :exercises, through: :group_exercises

end
