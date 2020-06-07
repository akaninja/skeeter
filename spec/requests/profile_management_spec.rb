require 'rails_helper'

describe 'Profiles', type: :request do
  it 'should add user to following list' do
    user = create(:user, username: 'UserName')
    other_user = create(:user, username: 'OtherName')
    login_as user, :scope => :user

    post follow_profile_path(other_user)

    expect(response).to redirect_to(other_user.profile)
    expect(user.followings.include?(other_user)).to eq true
  end

  it 'should not follow if already following' do
    user = create(:user, username: 'UserName')
    other_user = create(:user, username: 'OtherName')
    FollowingUser.create(user: user, following: other_user)
    login_as user, :scope => :user

    post follow_profile_path(other_user)

    expect(response).to redirect_to(other_user.profile)
    expect(user.followings.count).to eq 1
  end
end
