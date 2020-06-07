FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{ n }@email.com" }
    password { '123456' }
    sequence(:username) { |n| "username#{ n }" }
  end
end
