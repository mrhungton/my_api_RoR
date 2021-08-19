class AddBlockedAtToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :blocked_at, :datetime
  end
end
