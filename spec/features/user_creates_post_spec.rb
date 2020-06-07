require 'rails_helper'

feature 'User creates a post' do
  scenario 'successfully' do
    user = User.create(email: 'user@email.com', password: '123456',
                       username: 'user_name' )
    login_as user, :scope => :user

    visit root_path

    fill_in 'Mensagem', with: 'Olá pessoal, essa é minha primeira mensagem'
    click_on 'Enviar'
    publication = Publication.last

    within(:css, ".timeline") do
      expect(page).to have_css('p', text: '@user_name')
      expect(page).to have_css('p', text: 'Olá pessoal, essa é minha primeira '\
                               'mensagem')
      expect(page).to have_content(publication.created_at)
    end
  end

  scenario 'and only sees last 5 posts' do
    user = User.create(email: 'user@email.com', password: '123456',
                       username: 'user_name')
    login_as user, scope: :user
    6.times do |p|
      Publication.create(message: " Message: #{ p }", user: user)
    end
    visit root_path

    within(:css, ".timeline") do
      expect(page).not_to have_content("Message: 0")
      expect(page).to have_content("Message: 1")
      expect(page).to have_content("Message: 2")
      expect(page).to have_content("Message: 3")
      expect(page).to have_content("Message: 4")
      expect(page).to have_content("Message: 5")
    end
  end

  scenario 'and only sees following publications' do
    user = User.create(email: 'user@email.com', password: '123456',
                       username: 'user_name')
    following = User.create(email: 'following@email.com', password: '123456',
                            username: 'follow')
    not_following = User.create(email:'not@email.com', password: '123456',
                                username: 'follow2')
    FollowingUser.create(user: user, following: following)
    login_as user, scope: :user
    Publication.create!(message: 'Message by following user', user: following)
    Publication.create!(message: 'Message by user', user: user)
    Publication.create!(message: 'Message by user not following',
                        user: not_following)
    visit root_path

    within(:css, ".timeline") do
      expect(page).to have_content('Message by following user')
      expect(page).to have_content('Message by user')
      expect(page).not_to have_content('Message by not following user')
    end
  end
end
