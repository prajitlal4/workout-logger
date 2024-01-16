class ExercisesController < ApplicationController

  def index
    @routine = Routine.where(group_id: current_group.id).find(params[:routine_id])
    @categories = Category.includes(:exercises).where(group_id: current_group.id)
  end

  def new
    @routine = Routine.find(params[:routine_id])
    @group = Group.find(params[:group_id])
    @exercise = Exercise.new
    @categories = Category.where(group_id: @group.id)
    @exercise_types = ExerciseType.all
  end

  def create
    @exercise = Exercise.new(exercise_params)
    @group = Group.find(params[:group_id])
    @routine = Routine.find(params[:routine_id])
    @exercise.group = @group

    if @exercise.save
      redirect_to group_routine_exercises_path(@group, @routine), notice: 'Exercise was successfully added.'
    else
      render :new
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :category_id, :exercise_type_id, :group_id, :routine_id)
  end

  def current_group
    @current_group ||= Group.find(params[:group_id])
  end
end
