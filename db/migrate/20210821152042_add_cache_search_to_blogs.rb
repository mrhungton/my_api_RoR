class AddCacheSearchToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :cache_search, :text
  end
end
