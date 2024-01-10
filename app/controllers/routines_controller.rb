class RoutinesController < ApplicationController

  def index
    # Fetch routines for the current workspace
    @routines = Routine.where(workspace_id: current_workspace.id)
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
    @routine.workspace = current_workspace

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

  private

  def routine_params
    params.require(:routine).permit(:name, :description)
  end

  # Implement current_workspace to retrieve the workspace the current user belongs to
  def current_workspace
    @current_workspace ||= Workspace.find_by(id: current_user.current_workspace_id)
  end
end
