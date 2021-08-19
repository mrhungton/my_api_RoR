class User < ApplicationRecord
  validates :role, presence: true, inclusion: { in: %w{admin user} }
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  # validates :password, presence: true, length: { minimum: 6 }
  validates :password_digest, presence: true
  has_secure_password

  # block user
  def block
    self.update(blocked_at: Time.now)
  end

  # unblock user
  def unblock
    self.update(blocked_at: nil)
  end
end
