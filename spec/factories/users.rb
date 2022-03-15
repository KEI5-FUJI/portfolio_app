FactoryBot.define do
  factory :user do
    name {"keigo"}
    email {"test@ex.com"}
    password { "password" }
    confirmed_at { Date.today }
    created_at {Date.today}
    updated_at {Date.today}
  end
end