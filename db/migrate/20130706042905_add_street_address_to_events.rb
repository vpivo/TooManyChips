class AddStreetAddressToEvents < ActiveRecord::Migration
  def change
    add_column :events, :street_address, :string
  end
end
