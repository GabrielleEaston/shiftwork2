class User < ApplicationRecord
  has_secure_password

  before_save { self.email = email.downcase }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :user_type, presence: true, inclusion: { in: %w(organization worker) }

  has_one :organization

  def has_org?
    Organization.where(user_id: self.id).count == 1
  end
end
