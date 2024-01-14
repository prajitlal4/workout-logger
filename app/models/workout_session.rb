class WorkoutSession < ApplicationRecord
  belongs_to :routine
  belongs_to :user
  belongs_to :group
  has_many :session_exercises

  def ended?
    end_time.present?
  end
end
