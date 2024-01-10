class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:show, :edit, :update, :destroy]
  before_action :check_membership, only: [:show, :edit, :update, :destroy]

  def index
    Rails.logger.debug "Current Account: #{Current.account.inspect}"
    Rails.logger.debug "Current User: #{Current.user.inspect}"
    @owned_workspaces = Workspace.owned_by_current_account
    @workspaces = Workspace.membership_except_owned(Current.user)
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
    @routines = @workspace.routines
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description, :user_id)
  end

  def set_workspace
    @workspace = Workspace.find(params[:id])
  end

  def check_membership
    unless @workspace.created_by_user == current_user ||
           @workspace.workspace_members.exists?(user_id: current_user.id)
      redirect_to workspaces_path, alert: 'You do not have permission to access this workspace.'
    end
  end

end
