class Blog < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true

  belongs_to :user
  has_many :likes_blogs, dependent: :destroy

  scope :filter_by_keyword, lambda { |keyword|
    where('lower(title) LIKE ?', "%#{keyword.downcase}%")
  }

  scope :recent, lambda { 
    order(:updated_at)
  }

  scope :filter_with_published, lambda { 
    where.not(published_date: nil)
  }

  scope :not_published, lambda {
    where(published_date: nil)
  }

  scope :published, lambda {
    where('published_date is not NULL')
  }

  # seach engine
  def self.search(params={})
    query = params[:blog_ids].present? ? Blog.where(id: params[:blog_ids]) : Blog.all

    # if params[:not_published] == true
    #   query = query.not_published
    # end

    # if params[:published] == true
    #   query = query.published
    # end

    if params[:keyword].present?
      query = query.filter_by_keyword(params[:keyword])
    end

    if params[:recent].present?
      query = query.recent
    end

    query
  end

  # Update cache search
  # after_save :update_cache_search
  # def update_cache_search
  #   str = []
  #   str << title.to_s.downcase.strip

  #   self.update(:cache_search, str.join(" ") + " " + str.join(" ").to_ascii)
  # end

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
