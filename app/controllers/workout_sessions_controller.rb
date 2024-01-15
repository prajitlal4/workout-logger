class WorkoutSessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  def index
    @workout_sessions = WorkoutSession.where(routine_id: params[:routine_id])
  end

  def show
    @workout_session = WorkoutSession.includes(session_exercises: :routine_exercise).find(params[:id])
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
        initial_set_details = Array.new(routine_exercise.sets) { { reps: nil, weight: nil, note: "" } }
        session_exercise = @workout_session.session_exercises.create!(
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

  def update
    if @workout_session.update(workout_session_params)
      redirect_to group_routine_path(@workout_session.group_id, @workout_session.routine_id), notice: 'WorkoutSession was successfully updated.'
    else
      render :edit
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

  def update_exercises
    Rails.logger.debug params.inspect
    @workout_session = WorkoutSession.find(params[:id])

    SessionExercise.transaction do
      session_exercises_params.each do |exercise_params|
        session_exercise = SessionExercise.find(exercise_params[:id])
        session_exercise.update!(exercise_params)
      end
    end
    redirect_to @workout_session, notice: 'WorkoutSession exercises updated successfully.'
  rescue ActiveRecord::RecordInvalid
    # Handle error
    render :show
  end

  private

  def set_session
    @workout_session = WorkoutSession.find(params[:id])
  end

  def workout_session_params
    params.require(:workout_session).permit(
      :start_time,
      :end_time,
      :bodyweight,
      :notes,
      :routine_id,
      session_exercises_attributes: [:id, :sets, :reps, :weight, :note, :routine_exercise_id, set_details: []]
    )
  end
end
