class WorkspacesController < ApplicationController
  def index
    @workspaces = Workspace.joins(:workspace_members).where(workspace_members: { user_id: current_user.id })
  end

  def new
    @workspace = Workspace.new
  end

  def create
    @workspace = Workspace.new(workspace_params)
    @workspace.created_by_user = current_user

    if @workspace.save
      # Automatically create a membership for the user who created the workspace
      WorkspaceMember.create!(workspace: @workspace, user: current_user)

      redirect_to @workspace, notice: 'Workspace was successfully created.'
    else
      render :new
    end
  end

  def show
    @workspace = Workspace.find(params[:id])
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description, :user_id)
  end

end
