class Blog < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, uniqueness: true, length: { maximum: 50 }
end
