FactoryBot.define do
  factory :publication do
    sequence :message do |n|
      "This is a message #{ n }"
    end
    user
  end
end
