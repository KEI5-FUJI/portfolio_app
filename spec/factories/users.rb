FactoryBot.define do
  factory :user do
    email {"email@ex.com"}
    password { "12345678" }
    confirmed_at { Date.today }
    created_at {Date.today}
    updated_at {Date.today}
  end
end