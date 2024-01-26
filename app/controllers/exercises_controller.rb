class ExercisesController < ApplicationController

  def index
    @routine = Routine.where(group_id: current_group.id).find(params[:routine_id])
      # Fetch categories that are global or belong to the current user
    @categories = Category.where(user_id: [current_user.id, nil])

    # Create a hash to store exercises for each category
    @category_exercises = {}

    # For each category, store filtered exercises in the hash
    @categories.each do |category|
      @category_exercises[category.id] = category.exercises.where(user_id: [current_user.id, nil])
    end
  end

  def new
    @routine = Routine.find(params[:routine_id])
    @group = Group.find(params[:group_id])
    @exercise = Exercise.new
    @categories = Category.where(user: [current_user, nil])
    @exercise_types = ExerciseType.all
  end

  def create
    @routine = Routine.find(params[:routine_id])
    @group = Group.find(params[:group_id])
    @exercise = current_user.exercises.build(exercise_params)

    if @exercise.save
      GroupExercise.create(exercise: @exercise, group: @group)
      redirect_to group_routine_exercises_path(@group, @routine), notice: 'Exercise was successfully added.'
    else
      render :new
    end
  end

  # CUSTOM CONTROLLER ACTIONS
  def copy_to_my_exercises
    group_exercise = GroupExercise.find(params[:id])
    new_exercise = current_user.exercises.create(group_exercise.exercise.attributes.except('id', 'created_at', 'updated_at', 'user_id'))

    if new_exercise.persisted?
      redirect_to my_exercises_path, notice: 'Exercise copied to your list.'
    else
      redirect_to group_path(group_exercise.group_id), alert: 'Unable to copy exercise.'
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :category_id, :exercise_type_id, :user_id, :routine_id)
  end

  def current_group
    @current_group ||= Group.find(params[:group_id])
  end
end
