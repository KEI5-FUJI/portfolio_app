class Request < ApplicationRecord
  belongs_to :user
  validates :request_name, presence: true, length: {maximum: 50}
  validates :request_detail, presence: true, length: {maximum: 300}
  validates :reward, length: {maximum: 100}
end
