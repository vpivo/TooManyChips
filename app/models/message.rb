class Message < ActiveRecord::Base
  validates_presence_of :subject, :message
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :reciepient, :class_name => 'User', :foreign_key => 'reciepient_id'
end