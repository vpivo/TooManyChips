class AddCustomGuestItems < ActiveRecord::Migration
  def change
    add_column :event_items, :guest_created, :boolean, :default => :false
  end
end
