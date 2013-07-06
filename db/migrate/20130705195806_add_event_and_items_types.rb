class AddEventAndItemsTypes < ActiveRecord::Migration
  def up
    add_column :events, :image, :string
    add_column :events, :state, :string
    add_column :events, :city, :string
    add_column :events, :zip, :string
    add_column :events, :type_id, :integer
    add_column :items, :type_id, :integer

    create_table :types do |t|
      t.string :name
      t.references :typeable, polymorphic: true
    end

  end

  def down
    remove_column :events, :image
    drop_table :types
    remove_column :events, :state
    remove_column :events, :city
    remove_column :events, :zip
    remove_column :events, :type_id
    remove_column :items, :type_id
  end
end
