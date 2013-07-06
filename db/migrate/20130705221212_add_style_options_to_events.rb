class AddStyleOptionsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :font_color, :string
    add_column :events, :font_family, :string
    add_column :events, :allow_guest_create, :boolean, :default => :false
    add_column :events, :background_color, :string
    add_column :events, :host_name, :string

  end
end
