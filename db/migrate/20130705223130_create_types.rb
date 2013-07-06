class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|

      t.timestamps
    end
  end
end
