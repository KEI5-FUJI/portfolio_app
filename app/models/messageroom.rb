class Messageroom < ApplicationRecord
  belongs_to :request
  has_many :messages, dependent: :destroy
end
