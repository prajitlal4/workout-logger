class ExercisesController < ApplicationController

  def index
    @routine = Routine.where(group_id: current_group.id).find(params[:routine_id])
    @categories = Category.includes(:exercises).where(group_id: current_group.id)
  end

  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.group = current_group

    if @exercise.save
      redirect_to @excerise, notice: 'Exercise was successfully added.'
    else
      render :new
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :category_id, :exercise_type_id, :group_id)
  end

  def current_group
    @current_group ||= Group.find(params[:group_id])
  end
end
