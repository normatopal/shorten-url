class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
        t.string :short_url, :null => false, :default => ""
        t.string :long_url, :null => false, :default => ""
        t.integer :clicks_count, :limit => 8, :default => 0
        t.timestamps
    end

    change_column :links, :id , "bigint NOT NULL AUTO_INCREMENT"

    add_index :links, :short_url, :unique => true
  end
end
