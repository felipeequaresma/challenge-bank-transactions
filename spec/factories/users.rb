FactoryBot.define do
  factory :user do
    cpf { Faker::IDNumber.brazilian_id}
    password { "123456" }
    association :account
  end
end
