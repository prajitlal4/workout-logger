class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workspace_members
  has_many :workspaces, through: :workspace_members
  has_many :workout_routines
  has_many :workout_sessions

  belongs_to :account
end
