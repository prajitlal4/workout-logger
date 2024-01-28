class WorkoutSessionsController < ApplicationController
  include WorkoutSessionsHelper
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  def index
    @workout_sessions = WorkoutSession.where(routine_id: params[:routine_id])
  end

  def show
    @workout_session = WorkoutSession.includes(:session_exercises).find(params[:id])

    # Assuming each routine exercise is part of the workout session
    @workout_session.routine.routine_exercises.each do |routine_exercise|
      # Check if a session exercise for this routine exercise already exists in this workout session
      session_exercise = @workout_session.session_exercises.find_by(exercise_id: routine_exercise.exercise_id)

      unless session_exercise
        # Fetch last values or default values
        last_values = last_values_for_exercise(routine_exercise.exercise, current_user, routine_exercise.sets)

        # Build a new session exercise with the last or default values
        @workout_session.session_exercises.build(
          exercise_id: routine_exercise.exercise_id,
          set_details: Array.new(routine_exercise.sets) { last_values }
        )
      end
    end
  end

  def new
    @workout_session = WorkoutSession.new
  end

  def edit
  end

  def create
    @routine = Routine.find(params[:routine_id])
    @group = @routine.group
    @workout_session = WorkoutSession.new(routine: @routine, start_time: Time.current, user: current_user, group: @group)
    @workout_session.routine.routine_exercises.each do |routine_exercise|
      last_values = last_values_for_exercise(routine_exercise.exercise, current_user, routine_exercise.sets)

      session_exercise = @workout_session.session_exercises.build(
        exercise_id: routine_exercise.exercise_id,
        set_details: last_values,
        routine_exercise_id: routine_exercise.id
      )

    end
    if @workout_session.save
      redirect_to workout_session_path(@workout_session), notice: 'Session started successfully.'
    else
      redirect_to group_routine_path(@routine.group_id, @routine), alert: 'Error starting workout_session.'
    end
  end

  def destroy
    @workout_session.destroy
    redirect_to workout_sessions_url, notice: 'Session was successfully destroyed.'
  end

  # CUSTOM CONTROLLER ACTIONS

  def end_session
    @workout_session = WorkoutSession.find(params[:id])
    if @workout_session.update(end_time: Time.current)
      redirect_to workout_session_path(@workout_session), notice: 'Session ended.'
    else
      redirect_to workout_session_path(@workout_session), alert: 'Could not end the workout_session. Please try again.'
    end
  end

  def update
    @workout_session = WorkoutSession.find(params[:id])

    session_exercises_attrs = params.dig(:workout_session, :session_exercises_attributes)

    ActiveRecord::Base.transaction do
      session_exercises_attrs&.each do |_key, attrs|
        session_exercise = @workout_session.session_exercises.find(attrs[:id])

        if attrs[:set_details].is_a?(Array)
          # Assuming set_details is an array of hashes
          set_details_array = attrs[:set_details].map(&:to_unsafe_h).map(&:to_h)
          session_exercise.set_details = set_details_array
        end

        session_exercise.save!
      end
    end

    redirect_to @workout_session, notice: 'Session updated successfully.'
  rescue ActiveRecord::RecordInvalid => e
    render :edit, status: :unprocessable_entity
  end

  private

  def set_session
    @workout_session = WorkoutSession.find(params[:id])
  end

  def workout_session_params
    params.require(:workout_session).permit(
      :start_time, :end_time, :bodyweight, :notes, :routine_id,
      session_exercises_attributes: [
        :id,
        { set_details: [:reps, :weight, :note] }
      ]
    )
  end

  def session_exercises_params
    params.require(:session_exercises).map do |_, exercise_params|
      exercise_params.permit(:id, set_details: [:reps, :weight, :note])
    end
  end

  def update_set_details
    params[:session_exercises].each_with_index do |session_exercise_param, index|
      session_exercise = @workout_session.session_exercises.find(session_exercise_param[:id])
      session_exercise.update(set_details: session_exercise_param[:set_details].values)
    end
  end

end
