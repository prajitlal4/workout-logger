module WorkoutSessionsHelper
  def last_value_for_exercise(exercise, attribute)
    last_session_exercise = SessionExercise.joins(:routine_exercise)
                                           .where(routine_exercises: { exercise_id: exercise.id })
                                           .order(created_at: :desc)
                                           .first
    Rails.logger.debug last_session_exercise.inspect
    last_session_exercise ? last_session_exercise[attribute] : 0
  end
end
