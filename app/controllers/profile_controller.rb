class ProfileController < ApplicationController
  before_action :set_profile, only: [:edit, :update]

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to user_path(@profile.user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :location, :bio, :avatar)
  end
end
