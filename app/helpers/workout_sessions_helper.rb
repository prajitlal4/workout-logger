module WorkoutSessionsHelper
  def last_values_for_exercise(exercise, user)
    last_session_exercise = SessionExercise
                              .joins(:workout_session)
                              .where(exercise_id: exercise.id, workout_sessions: { user_id: user.id })
                              .order(created_at: :desc)
                              .first

    if last_session_exercise && last_session_exercise.set_details.present?
      last_session_exercise.set_details.last
    else
      { 'reps' => 0, 'weight' => 0, 'note' => '' }
    end
  end
end
