module WorkoutSessionsHelper
  def last_values_for_exercise(exercise)
    last_session_exercise = SessionExercise.where(exercise_id: exercise.id).order(created_at: :desc).first
    last_session_exercise&.set_details&.last || { 'reps' => 0, 'weight' => 0, 'note' => '' }
  end
end
