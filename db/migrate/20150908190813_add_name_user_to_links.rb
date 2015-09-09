class AddNameUserToLinks < ActiveRecord::Migration
  def change
    add_column :links, :name, :string
    add_column :links, :user_id, :integer
    add_index :links, :user_id
  end
end
