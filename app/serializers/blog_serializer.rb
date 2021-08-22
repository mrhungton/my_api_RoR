class BlogSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :content, :url
  attribute :total_likes do |object|
    object.total_likes
  end
  belongs_to :user
  link :url_friendly do |object, params|
    "/blogs/#{object.url}-#{object.id}"
  end
end
