class User < ApplicationRecord
  validates :name, presence: true, length: { minium: 5, maximum: 50 }
  validates :role, presence: true, inclusion: { in: %w{admin user} }
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_digest, presence: true
  has_secure_password
  
  has_many :blogs, dependent: :destroy
  has_many :likes_blogs, dependent: :destroy

  scope :filter_by_keyword, lambda { |keyword|
    where('lower(name) LIKE ? OR lower(email) LIKE ?', "%#{keyword.downcase}%", "%#{keyword.downcase}%")
  }

  scope :recent, lambda { 
    order(:created_at)
  }
  
  scope :not_blocked, lambda {
    where(blocked_at: nil)
  }

  scope :blocked, lambda {
    where('blocked_at is not NULL')
  }

  # seach engine
  def self.search(params={})
    query = params[:user_ids].present? ? User.where(id: params[:user_ids]) : User.all

    # if params[:not_blocked] == true
    #   query = query.not_blocked
    # end

    # if params[:blocked] == true
    #   query = query.blocked
    # end

    if params[:keyword].present?
      query = query.filter_by_keyword(params[:keyword])
    end

    if params[:recent].present?
      query = query.recent
    end

    query
  end

  # user active
  def active?
    return blocked_at.nil?
  end

  # block user
  def block
    self.update(blocked_at: Time.now) if blocked_at.nil?
  end

  # unblock user
  def unblock
    self.update(blocked_at: nil)
  end
end
