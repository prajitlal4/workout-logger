class RoutineExercisesController < ApplicationController
  before_action :set_routine_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @routine_exercises = RoutineExercise.where(routine_id: params[:routine_id])
  end

  def show
  end

  def new
    @routine_exercise = RoutineExercise.new
  end

  def edit
  end

  def create
    @routine_exercise = RoutineExercise.new(routine_exercise_params)

    if @routine_exercise.save
      redirect_to @routine_exercise, notice: 'Routine exercise was successfully created.'
    else
      render :new
    end
  end

  def update
    if @routine_exercise.update(routine_exercise_params)
      redirect_to @routine_exercise, notice: 'Routine exercise was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @routine_exercise.destroy
    redirect_to routine_exercises_url, notice: 'Routine exercise was successfully destroyed.'
  end

  private

  def set_routine_exercise
    @routine_exercise = RoutineExercise.find(params[:id])
  end

  def routine_exercise_params
    params.require(:routine_exercise).permit(:name, :note, :sets, :category_id, :exercise_type_id, :routine_id)
  end
end
