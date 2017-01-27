class User < ApplicationRecord
  include ActiveModel::Validations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :email, presence: true, email: true, uniqueness: true

  def self.from_omniauth(auth)
    find_or_create_by(email: auth.info.email) do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0, 20]
      # user.autogenerated_password = true
    end
  end


end
