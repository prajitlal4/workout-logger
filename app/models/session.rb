class Session < ApplicationRecord
  belongs_to :routine
  belongs_to :user
  belongs_to :group
  has_many :session_exercises, dependent: :destroy
end
