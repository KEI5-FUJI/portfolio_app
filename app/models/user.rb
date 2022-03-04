class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :requests
  validates :name, presence: true, length: {maximum: 20}
  geocoded_by :now_place
  after_validation :geocode, if: :now_place_changed?
  acts_as_mappable :lat_column_name => :lat,
                   :lng_column_name => :lng
end
