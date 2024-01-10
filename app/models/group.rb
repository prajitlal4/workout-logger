class Group < ApplicationRecord

  belongs_to :created_by_user, class_name: 'User'
  has_many :group_members
  has_many :users, through: :group_members
  has_many :routines
  has_many :sessions

end
