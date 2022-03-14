class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:twitter]
  has_many :requests, dependent: :destroy
  has_many :messages, dependent: :destroy
  validates :name, presence: true, length: {maximum: 20}
  geocoded_by :now_place
  after_validation :geocode, if: :now_place_changed?
  acts_as_mappable :lat_column_name => :lat,
                   :lng_column_name => :lng

  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)
    user || User.create!(
           uid: auth.uid,
           provider: auth.provider,
           name: auth[:info][:name],
           email: User.dummy_email(auth),
           password: Devise.friendly_token[0, 20]
    )
    user
  end
  
  def self.dummy_email(auth)
       "#{Time.now.strftime("%Y%M%d%H%M%S").to_i}-#{auth.uid}-#{auth.provider}@example.com"
  end

  def self.all_user_minus_one_user(one_user)
    User.where("id != ?", one_user.id)
  end
end
