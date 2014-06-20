class AddPrivateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :reciepient_id
      t.string :subject
      t.string :message
      t.boolean :read
      t.timestamps
    end
  end

end
