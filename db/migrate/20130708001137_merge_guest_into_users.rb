class MergeGuestIntoUsers < ActiveRecord::Migration
  def change
    drop_table :guests
    add_column :users, :guest, :boolean, :default => :false
    add_column :users, :url, :string
  end
end
 