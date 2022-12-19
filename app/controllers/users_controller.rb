class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
    if params[:query]
      @users = @users.query(params[:query])
    else
      @users
    end
  end

  def show
    @user = User.find(params[:id])
    @feed = @user.feed
  end
end