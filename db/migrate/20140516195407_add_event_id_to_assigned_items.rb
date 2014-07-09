class AddEventIdToAssignedItems < ActiveRecord::Migration
  def change
    add_column :assigned_items, :event_id, :integer
  end
end
