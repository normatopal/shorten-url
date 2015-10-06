class AddDeletedAtToUsersAndLinks < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime
    add_column :links, :deleted_at, :datetime
  end
end
