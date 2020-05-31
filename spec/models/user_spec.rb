require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    it 'should create user profile' do
      user = User.create(email:'user@email.com', password: '123456', username: 'ahk')

      expect(user.profile).not_to be_nil
      expect(user.profile.user).to eq user
    end
  end
end
