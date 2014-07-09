class AddEventIdToAssignedItems < ActiveRecord::Migration
  def change
    add_column :assigned_items, :event_id, :integer

    AssignedItem.all.each do |i| 
      i.event_id = i.event_item.event.id if i.event_item.event.id
      i.save!
    end
  end
end
