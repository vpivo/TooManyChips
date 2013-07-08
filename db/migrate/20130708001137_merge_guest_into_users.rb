class MergeGuestIntoUsers < ActiveRecord::Migration
  def change
    drop_table :guests
    add_column :users, :guest, :boolean, :default => :false
    add_column :users, :url, :string
    remove_column :assigned_items, :guest_id
    add_column :assigned_items, :user_id, :integer
  end
end
 