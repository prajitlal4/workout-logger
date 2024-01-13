class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  def index
    @sessions = Session.where(routine_id: params[:routine_id])
  end

  def show
    @session = Session.includes(session_exercises: :routine_exercise).find(params[:id])
  end

  def new
    @session = Session.new
  end

  def edit
  end

  def create
    @routine = Routine.find(params[:routine_id])
    @group = @routine.group
    @session = Session.new(routine: @routine, start_time: Time.current, user: current_user, group: @group)

    if @session.save
      @routine.routine_exercises.each do |routine_exercise|
        initial_set_details = Array.new(routine_exercise.sets) { { reps: nil, weight: nil, note: "" } }
        session_exercise = @session.session_exercises.create(
          routine_exercise: routine_exercise,
          exercise: routine_exercise.exercise,
          set_details: initial_set_details
        )
        if session_exercise.errors.any?
          Rails.logger.debug session_exercise.errors.full_messages.to_sentence
        end
      end
      redirect_to session_path(@session), notice: 'Session started successfully.'
    else
      Rails.logger.debug @session.errors.full_messages.to_sentence
      redirect_to group_routine_path(@routine.group_id, @routine), alert: 'Error starting session.'
    end
  end

  def update
    if @session.update(session_params)
      redirect_to group_routine_path(@session.group_id, @session.routine_id), notice: 'Session was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @session.destroy
    redirect_to sessions_url, notice: 'Session was successfully destroyed.'
  end

  # CUSTOM CONTROLLER ACTIONS

  def end_session
    @session = Session.find(params[:id])
    if @session.update(end_time: Time.current)
      redirect_to session_path(@session), notice: 'Session ended.'
    else
      redirect_to session_path(@session), alert: 'Could not end the session. Please try again.'
    end
  end

  def update_exercises
    Rails.logger.debug params.inspect
    @session = Session.find(params[:id])

    SessionExercise.transaction do
      session_exercises_params.each do |exercise_params|
        session_exercise = SessionExercise.find(exercise_params[:id])
        session_exercise.update!(exercise_params)
      end
    end
    redirect_to @session, notice: 'Session exercises updated successfully.'
  rescue ActiveRecord::RecordInvalid
    # Handle error
    render :show
  end

  private

  def set_session
    @session = Session.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:start_time, :end_time, :bodyweight, :notes, :routine_id)
  end

  def session_exercises_params
    params.require(:session_exercises).map do |_, exercise_params|
      exercise_params.permit(:id, :sets, :reps, :weight, :set_details)
    end
  end
end
