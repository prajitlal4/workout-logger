class WorkspacesController < ApplicationController
  def index
    @workspaces = Workspace.joins(:workspace_members).where(workspace_members: { user_id: current_user.id })
  end

  def show
    @workspace = Workspace.find(params[:id])
  end

end
