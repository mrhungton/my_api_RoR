class CreateLikesBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :likes_blogs do |t|
      t.belongs_to :blog, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.index [:blog_id, :user_id], unique: true

      t.timestamps
    end
  end
end
