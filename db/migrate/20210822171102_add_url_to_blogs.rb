class AddUrlToBlogs < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :url, :string
  end
end
