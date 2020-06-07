require 'rails_helper'

feature 'User fills profile  info' do
  scenario 'successfully' do
    user = create(:user, email: 'user@email.com', password: '123456',
                  username:'apelido')
    other_user = create(:user, email:'other_user@email.com', password: '123456',
                        username:'nick')
    another_user = create(:user, email:'another_user@email.com', password: '123456',
                          username: 'annita')
    FollowingUser.create(user: user, following: other_user)
    FollowingUser.create(user: user, following: another_user)
    login_as user, :scope => :user

    visit root_path
    within('div.sidebar') do
      click_on '@apelido'
    end
    click_on 'Editar perfil'
    fill_in 'Nome', with: 'Pedro Silva'
    fill_in 'Bio', with: 'Pipoqueiro da praça'
    click_on 'Salvar'

    expect(page).to have_content('Pedro Silva')
    expect(page).to have_content('Pipoqueiro da praça')
    expect(page).to have_content('@apelido')
    expect(page).to have_content('2 Seguindo')
  end

  scenario 'and must be logged in' do
    user = create(:user, email: 'user@email.com', password: '123456',
                  username:'apelido')

    visit profile_path(user.profile)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and must be profile owner' do
    user = create(:user, username: 'UserName')
    other_user = create(:user, username: 'OtherUser')
    login_as user, :scope => :user

    visit profile_path(other_user.profile)

    expect(page).not_to have_content('Editar perfil')
  end
end
