User.create!(
  name: "Keigo",
  email: "keigo@kei.com",
  password: "password",
  password_confirmation: "password",
  confirmed_at: Date.today,
  created_at: Date.today,
  updated_at: Date.today
)

99.times do |n|
  name = Faker::Name.name
  email = "keigo@kei#{n+1}.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    confirmed_at: Date.today,
    created_at: Date.today,
    updated_at: Date.today
  )

  users = User.order(:created_at).take(6)
  50.times do
    request_name = Faker::Lorem.sentence(word_count: 5)
    request_detail = Faker::Lorem.sentence(word_count: 5)
    reward = Faker::Lorem.sentence(word_count: 5)
    users.each { |user| user.requests.create!(request_name: request_name, request_detail: request_detail, reward: reward) }
  end
end