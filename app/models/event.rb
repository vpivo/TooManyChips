class Event < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  validates :name, :presence => true
  before_create :set_url
  attr_accessible :date, :description, :name,
    :host_provided, :location, :name, :start_time, :user_id,
    :event_items_attributes, :image, :font_color, :state, :city, 
    :zip, :type_id, :font_family, 
    :allow_guest_create, :background_color, :host_name, :type,
     :end_time, :street_address, :remote_image_url
  belongs_to :host, :class_name => "User", :foreign_key => 'user_id'
  has_one :type, :as => :typeable
  has_many :event_items, :inverse_of => :event, :dependent => :destroy
  has_many :items, :through => :event_items
  has_many :assigned_items, :through => :event_items, :dependent => :destroy
  has_many :guests, :through => :assigned_items, :class_name => "User", :foreign_key => "user_id"  

  accepts_nested_attributes_for :event_items, :reject_if => :all_blank, :allow_destroy => true
  def set_url
    self.url ||= SecureRandom.urlsafe_base64
  end

  def upcoming?
    self.date  > DateTime.now
  end

  def past?
    self.date  <= DateTime.now
  end

  def get_guests
    self.assigned_items.map {|item| (item.guest) }.uniq
  end

  
end
