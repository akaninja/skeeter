require 'rails_helper'

feature 'Visitor views home page' do
  scenario 'successfully' do
    user = User.create(email: 'user@email.com', password: '123456')
    Publication.create(message:'This is a post.')
    login_as user, :scope => :user
    visit root_path

    expect(page).to have_content('Welcome to Skeeter')
    expect(page).not_to have_content('This is a post.')
  end
end
