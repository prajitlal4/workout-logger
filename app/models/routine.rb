class Routine < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
  has_many :sessions
  has_many :routine_exercises
end
