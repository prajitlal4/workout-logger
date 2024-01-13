module SessionsHelper
  def last_value_for_exercise(exercise, attribute)
    SessionExercise.joins(:routine_exercise)
                   .where(routine_exercises: { exercise_id: exercise.id })
                   .order(created_at: :desc)
                   .pick(attribute) || 0
  end
end
