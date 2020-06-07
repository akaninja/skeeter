require 'rails_helper'

feature 'User follows other user' do
  scenario 'successfully' do
    user = create(:user, username: 'UsarName')
    other_user = create(:user, username: 'OtherUser')
    login_as user, :scope => :user

    visit profile_path(other_user.profile)
    click_on 'Seguir'

    expect(current_path).to eq profile_path(other_user.profile)
    expect(page).not_to have_link('Seguir')
    expect(user.followings.count).to eq 1
    expect(user.followings.last).to eq other_user
  end
end
