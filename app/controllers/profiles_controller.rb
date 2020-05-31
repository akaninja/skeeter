class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_profile = current_user.profile
  end

  def edit
    @user_profile = current_user.profile
  end

  def update
    @user_profile = current_user.profile
    @user_profile.update(profile_params)
    redirect_to @user_profile
  end

  def profile_params
    params.require(:profile).permit(:name, :bio)
  end

end
