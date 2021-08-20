class User < ApplicationRecord
  validates :name, presence: true, length: { minium: 5, maximum: 50 }
  validates :role, presence: true, inclusion: { in: %w{admin user} }
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  # validates :password, presence: true, length: { minimum: 6 }
  validates :password_digest, presence: true
  has_secure_password
  
  has_many :blogs, dependent: :destroy
  has_many :likes_blog, dependent: :destroy

  # block user
  def block
    self.update(blocked_at: Time.now)
  end

  # unblock user
  def unblock
    self.update(blocked_at: nil)
  end
end
