class Session < ApplicationRecord
  belongs_to :routine
  belongs_to :user
  belongs_to :workspace
  has_many :session_exercises
end
