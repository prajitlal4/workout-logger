class Routine < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
  has_many :sessions
end
