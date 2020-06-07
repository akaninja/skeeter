require 'rails_helper'

feature 'Visitor views home page' do
  scenario 'successfully' do
    create(:publication, message:'This is a post.')

    visit root_path

    expect(page).to have_content('Welcome to Skeeter')
    expect(page).not_to have_content('This is a post.')
    expect(page).not_to have_content('Timeline')
  end

  context 'and creates account' do
    scenario 'successfully' do
      visit root_path
      click_on 'Criar uma conta'
      fill_in 'Nome de Usuário', with: 'Pedroca'
      fill_in 'E-mail', with: 'user@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmar senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_content('@Pedroca')
    end

    scenario 'and username must be unique' do
      User.create(email:'user@email.com', password:'123456', username: 'Pedroca')
      visit root_path
      click_on 'Criar uma conta'
      fill_in 'Nome de Usuário', with: 'Pedroca'
      fill_in 'E-mail', with: 'other_user@email.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmar senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_content('Username has already been taken')
      expect(User.all.count).to eq 1
    end
  end

  scenario 'and logs in' do
    User.create(email: 'user@email.com', password: '123456', username: 'myname')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'user@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'

    expect(page).to have_content('@myname')
  end
end
