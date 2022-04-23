FactoryBot.define do
  factory :account do
    balance { Faker::Number.number(digits: 3) }
  end

  trait :with_user do
    after(:create) { |account| create_list(:user, 2, account: account) }
  end
end
