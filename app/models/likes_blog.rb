class LikesBlog < ApplicationRecord
  validates_uniqueness_of :blog, scope: :user

  belongs_to :blog, class_name: 'Blog'
  belongs_to :user, class_name: 'User'
end
