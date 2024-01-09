class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workspace_members
  has_many :workspaces, through: :workspace_members
  has_many :routines
  has_many :sessions

  belongs_to :account
end
