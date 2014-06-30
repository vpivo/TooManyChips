class User < ActiveRecord::Base
  require 'bcrypt'
  include ActiveModel::SecurePassword::InstanceMethodsOnActivation
  attr_reader :password #allow user to be guest ot registered

  validates_presence_of :name, :email
  validates :email, :uniqueness => {:case_sensitive => false, :message => "has already been registered"}, 
  :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, 
  :message => "must be a valid format" }
  validates :password, :length => {:minimum => 6, :too_short  => "must have at least 6 characters"}, unless: :guest? 
  validates_confirmation_of :password
  has_many :assigned_items, :dependent => :destroy
  has_many :event_items, :through => :assigned_items
  has_many :events
  has_many :assigned_items, :class_name => 'AssignedItem', :foreign_key => 'user_id'
  belongs_to :event, :class_name => 'User', foreign_key: 'user_id'
  accepts_nested_attributes_for :assigned_items, :event_items
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :recieved_messaged, :class_name => 'Message', :foreign_key => 'reciepientId'

  # after_save :registration_emails!
  before_create :set_url
  
  def get_contributions(id)
    self.assigned_items.select { |item| item if (item.event_id == id) }
  end

  def duplicate_item?(item)
    return !self.assigned_items.find_by_event_item_id(item["id"]).nil?
  end

  def add_items(items)
    items.each do |item|
      if self.duplicate_item?(item)
        existing_item = self.assigned_items.find_by_event_item_id(item["id"])
        existing_item.quantity_provided = (existing_item.quantity_provided + item["amountToBring"].to_i)
        existing_item.save!
      else
        self.assigned_items << AssignedItem.new(quantity_provided: item["amountToBring"].to_i, 
          event_item_id: item["id"], event_id: item["eventId"])
        self.save!
      end
    end
  end

  private

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.password = SecureRandom.hex(4)
      user.save!
    end
  end

  def set_url
   self.url ||= SecureRandom.urlsafe_base64 if self.guest
 end

 def registration_emails!
    # schedule_result_email unless self.result_date == nil
    send_email
  end



  # def schedule_result_email
  #   EmailWorker.perform_at(self.result_date, self.user_id, self.id, 'result')
  # end

  def send_email
    EmailWorker.perform_async(self.id)
  end

end




