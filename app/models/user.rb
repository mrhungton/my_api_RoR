class User < ApplicationRecord
  validates :role, presence: true, inclusion: { in: %w{admin user} }
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  # validates :password, presence: true, length: { minimum: 6 }
  validates :password_digest, presence: true


end
