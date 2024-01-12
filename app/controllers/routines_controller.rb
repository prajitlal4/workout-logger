class RoutinesController < ApplicationController

  def index
    # Fetch routines for the current group
    @routines = Routine.where(group_id: current_group.id)
  end

  def show
    @routine = Routine.find(params[:id])
  end

  def new
    @routine = Routine.new
  end

  def edit
  end

  def create
    @routine = Routine.new(routine_params)
    @routine.group = current_group

    if @routine.save
      redirect_to @routine, notice: 'Routine was successfully created.'
    else
      render :new
    end
  end

  def update
    if @routine.update(routine_params)
      redirect_to @routine, notice: 'Routine was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @routine.destroy
    redirect_to routines_url, notice: 'Routine was successfully destroyed.'
  end

  # CUSTOM CONTROLLER ACTIONS
  #
  def add_exercise
    @routine = Routine.find(params[:routine_id])
    exercise = Exercise.find(params[:exercise_id])

    RoutineExercise.create!(routine: @routine, exercise: exercise)

    redirect_to group_routine_path(@routine.group_id, @routine), notice: 'Exercise added successfully'
  end

  def update_exercises
    @routine = Routine.find(params[:id])
    ActiveRecord::Base.transaction do
      routine_exercises_params.each do |exercise_params|
        routine_exercise = @routine.routine_exercises.find(exercise_params[:id])
        routine_exercise.update!(sets: exercise_params[:sets])
      end
    end
    redirect_to group_routine_path(@routine.group_id, @routine), notice: 'All exercises were successfully updated.'
  rescue ActiveRecord::RecordInvalid
    render :show, alert: 'There was an error updating the exercises.'
  end

  private

  def routine_params
    params.require(:routine).permit(:name, :description)
  end

  def routine_exercises_params
    params.require(:routine_exercises).permit!.to_h.map do |_key, exercise_params|
      exercise_params.slice(:id, :sets) # This filters only the id and sets keys
    end
  end

  # Implement current_group to retrieve the group the current user belongs to
  def current_group
    @current_group ||= Group.find_by(id: current_user.current_group_id)
  end
end
