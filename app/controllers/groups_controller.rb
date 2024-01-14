class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :check_membership, only: [:show, :edit, :update, :destroy]

  def index
    @owned_groups = Group.where(created_by_user: current_user)
    @member_groups = Group.joins(:group_members)
                      .where(group_members: { user_id: current_user.id })
                      .where.not(created_by_user: current_user)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.created_by_user = current_user

    if @group.save
      # Automatically create a membership for the user who created the group
      GroupMember.create!(group: @group, user: current_user)

      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @routines = @group.routines
    @workout_sessions = @group.workout_sessions
  end

  # CUSTOM CONTROLLER ACTIONS
  def invite_to_group
    user_email = params[:email]
    group_id = params[:group_id]

    User.invite!({email: user_email, group_id: group_id}, current_user)
    redirect_to group_path(group_id), notice: "Invitation sent to #{user_email}"
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :user_id)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def check_membership
    unless @group.created_by_user == current_user ||
           @group.group_members.exists?(user_id: current_user.id)
      redirect_to groups_path, alert: 'You do not have permission to access this group.'
    end
  end

end
