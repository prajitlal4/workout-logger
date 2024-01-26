class GroupExercisesController < ApplicationController
  def new
    @group_exercise = GroupExercise.new
  end

  def create
    @group_exercise = GroupExercise.new(group_exercise_params)
    if @group_exercise.save
      redirect_to group_path(@group_exercise.group), notice: 'Exercise added to group.'
    else
      render :new
    end
  end

  private

  def group_exercise_params
    params.require(:group_exercise).permit(:group_id, :exercise_id)
  end
end
