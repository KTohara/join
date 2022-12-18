class UsersController < ApplicationController
  def index
    if params[:query]
      @users = User.query(params[:query])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
