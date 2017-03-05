class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :orders, dependent: :destroy

  has_one :billing_address,  as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy

  validates_uniqueness_of :email, allow_blank: true, if: :email_uniqueness_required?

  attr_accessor :skip_password_validation, :skip_email_uniqueness_validation

  def self.from_omniauth(auth)
    find_or_create_by(email: auth.info.email) do |user|
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def to_s
    email
  end

  private

  def email_uniqueness_required?
    skip_email_uniqueness_validation ? false : email_changed?
  end

  def password_required?
    skip_password_validation ? false : super
  end
end
