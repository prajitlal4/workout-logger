module WorkoutSessionsHelper
  def last_values_for_exercise(exercise, user, number_of_sets)
    last_session_exercise = SessionExercise
                              .joins(:workout_session)
                              .where(exercise_id: exercise.id, workout_sessions: { user_id: user.id })
                              .order(created_at: :desc)
                              .first

    # This will hold the final set details, either from the last session or default values
    set_details_array = Array.new(number_of_sets) { { 'reps' => 0, 'weight' => 0, 'note' => '' } }

    if last_session_exercise.present?
      # Take as many last set details as needed, up to the number_of_sets
      last_set_details = last_session_exercise.set_details.take(number_of_sets)
      last_set_details.each_with_index do |set_detail, index|
        set_details_array[index] = set_detail
      end
    end

    set_details_array
  end
end
