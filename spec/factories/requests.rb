FactoryBot.define do
  factory :request do
    request_name {"テストです。あれを借りたい。"}
    request_detail {"テストの投稿です。"}
    reward {"テストの報酬です。"}
    association :user
  end
end