class Blog < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true

  belongs_to :user
  has_many :likes_blogs, dependent: :destroy

  # publish
  def publish
    self.update(published_date: Time.now)
  end

  # unpublish
  def unpublish
    self.update(published_date: nil)
  end

  # like
  def like(user)
    likes_blogs.create(user_id: user.id)
  end

  # unlike
  def unlike(user)
    likes_blogs.where(user_id: user.id).destroy_all
  end
end
