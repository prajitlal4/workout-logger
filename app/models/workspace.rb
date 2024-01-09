class Workspace < ApplicationRecord
  include AccountOwnable

  belongs_to :created_by_user, class_name: 'User'
  has_many :workspace_members
  has_many :users, through: :workspace_members
  has_many :routines
  has_many :sessions

end
