require 'rails_helper'

feature 'User fills profile  info' do
  scenario 'successfully' do
    user = User.create!(email: 'user@email.com', password: '123456',
                        username:'apelido')
    other_user = User.create(email:'other_user@email.com', password: '123456',
                             username:'nick')
    another_user = User.create(email:'another_user@email.com', password: '123456',
                               username: 'annita')
    FollowingUser.create(user: user, following: other_user)
    FollowingUser.create(user: user, following: another_user)
    login_as user, :scope => :user

    visit root_path
    within('div.sidebar') do
      click_on '@apelido'
    end
    fill_in 'Nome', with: 'Pedro Silva'
    fill_in 'Bio', with: 'Pipoqueiro da praça'
    click_on 'Salvar'

    expect(page).to have_content('Pedro Silva')
    expect(page).to have_content('Pipoqueiro da praça')
    expect(page).to have_content('@apelido')
    expect(page).to have_content('2 Seguindo')
  end
end
