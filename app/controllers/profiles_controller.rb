class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_profile = Profile.find(params[:id])
  end

  def edit
    @user_profile = current_user.profile
  end

  def update
    @user_profile = current_user.profile
    @user_profile.update(profile_params)
    redirect_to @user_profile
  end

  def follow
    following = Profile.find(params[:id]).user
    user = current_user

    return redirect_to following.profile if user.followings.include?(following)

    FollowingUser.create(user: user, following: following)
    redirect_to following.profile
  end

  def profile_params
    params.permit(:name, :bio)
  end
end
