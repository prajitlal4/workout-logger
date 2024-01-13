class Routine < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :sessions
  has_many :routine_exercises

  accepts_nested_attributes_for :routine_exercises
end
