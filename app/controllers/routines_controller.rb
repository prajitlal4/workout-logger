class RoutinesController < ApplicationController

  def index
    @routines = Routine.where(group_id: params[:group_id])
  end

  def show
    @routine = Routine.find(params[:id])
  end

  def new
    @routine = Routine.new
    @group = Group.find(params[:group_id])
  end

  def edit
  end

  def create
    @routine = Routine.new(routine_params)
    @routine.group = Group.find(params[:group_id])
    @routine.user = current_user

    if @routine.save
      redirect_to group_path(@routine.group), notice: 'Routine was successfully created.'
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
    @routine = Routine.find(params[:id])
    @group = Group.find(params[:group_id])
    if @routine.destroy
      redirect_to group_path(@group), notice: 'Routine was successfully destroyed.'
    end
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

    routine_exercises_params[:routine_exercises].each do |id, exercise_params|
      routine_exercise = @routine.routine_exercises.find(id)
      routine_exercise.update(sets: exercise_params[:sets])
    end
  end

  private

  def routine_params
    params.require(:routine).permit(:name, :description)
  end

  def routine_exercises_params
    params.require(:routine).permit(routine_exercises: [:id, :sets])
  end

end
