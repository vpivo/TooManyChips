class RemoveUnusedEventColumns < ActiveRecord::Migration
  def up
  	remove_column :events, :font_family
  	remove_column :events, :background_color
  	remove_column :events, :type_id
  	add_column :events, :event_type, :string
  end

  def down
  	add_column :events, :font_family, :string
  	add_column :events, :background_color, :string
  	add_column :events, :type_id, :string
  	remove_column :events, :event_type
  end
end
