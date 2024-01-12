class RoutineExercisesController < ApplicationController
  before_action :set_routine
  before_action :set_routine_exercise, only: [:update, :destroy]

  def update
    if @routine_exercise.update(routine_exercise_params)
      # Redirect or render as per your requirements
      redirect_to @routine, notice: 'Exercise was successfully updated.'
    else
      # Handle error scenario
      redirect_to @routine, alert: 'Unable to update exercise.'
    end
  end

  def destroy
    @routine_exercise.destroy
    redirect_to group_routine_path(@routine.group_id, @routine), notice: 'Exercise was successfully removed.'
  end

  private

  def set_routine
    @routine = Routine.find(params[:routine_id])
  end

  def set_routine_exercise
    @routine_exercise = @routine.routine_exercises.find(params[:id])
  end

  def routine_exercise_params
    params.require(:routine_exercise).permit(:sets) # Adjust the permitted params as needed
  end
end
