class WorkoutSessionsController < ApplicationController
  include WorkoutSessionsHelper
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  def index
    @workout_sessions = WorkoutSession.where(routine_id: params[:routine_id])
  end

  def show
    @workout_session = WorkoutSession.includes(:session_exercises).find(params[:id])
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

    if @workout_session.save
      @routine.routine_exercises.each do |routine_exercise|
        set_count = routine_exercise.sets || 0
        initial_set_details = Array.new(set_count) do
          {
            reps: last_value_for_exercise(routine_exercise.exercise, :reps),
            weight: last_value_for_exercise(routine_exercise.exercise, :weight),
            note: last_value_for_exercise(routine_exercise.exercise, :note)
          }
        end
        session_exercise = @workout_session.session_exercises.create(
          routine_exercise: routine_exercise,
          exercise: routine_exercise.exercise,
          set_details: initial_set_details
        )
        if session_exercise.errors.any?
          Rails.logger.debug session_exercise.errors.full_messages.to_sentence
        end
      end
      redirect_to workout_session_path(@workout_session), notice: 'WorkoutSession started successfully.'
    else
      Rails.logger.debug @workout_session.errors.full_messages.to_sentence
      redirect_to group_routine_path(@routine.group_id, @routine), alert: 'Error starting workout_session.'
    end
  end

  def destroy
    @workout_session.destroy
    redirect_to workout_sessions_url, notice: 'WorkoutSession was successfully destroyed.'
  end

  # CUSTOM CONTROLLER ACTIONS

  def end_session
    @workout_session = WorkoutSession.find(params[:id])
    if @workout_session.update(end_time: Time.current)
      redirect_to workout_session_path(@workout_session), notice: 'WorkoutSession ended.'
    else
      redirect_to workout_session_path(@workout_session), alert: 'Could not end the workout_session. Please try again.'
    end
  end

  def update
    Rails.logger.debug "Received params: #{params.inspect}"
    @workout_session = WorkoutSession.find(params[:id])

    session_exercises_attrs = params.dig(:workout_session, :session_exercises_attributes)

    ActiveRecord::Base.transaction do
      session_exercises_attrs&.each do |_key, attrs|
        session_exercise = @workout_session.session_exercises.find(attrs[:id])

        # Ensure set_details is an array of hashes
        if attrs[:set_details].is_a?(ActionController::Parameters)
          set_details_array = attrs[:set_details].values.map(&:to_unsafe_h).map(&:to_h)
          session_exercise.set_details = set_details_array
        end

        Rails.logger.debug "Processed set_details: #{set_details_array.inspect}"

        # Save each session_exercise
        session_exercise.save!
      end
    end
      redirect_to @workout_session, notice: 'WorkoutSession updated successfully.'
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
