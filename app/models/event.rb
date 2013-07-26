class Event < ActiveRecord::Base
  validates :name, :presence => true
  before_create :set_url
 # after_save :enqueue_image
  attr_accessible :date, :description, :name,
    :host_provided, :location, :name, :start_time, :user_id,
    :event_items_attributes, :state, :city, :zip, :type_id, :allow_guest_create, 
    :host_name, :type, :end_time, :street_address, :remote_image_url, :image,
    :image_file_name, :image_content_type, :image_file_size, :image_updated_at
  belongs_to :host, :class_name => "User", :foreign_key => 'user_id'
  has_one :type, :as => :typeable
  has_many :event_items, :inverse_of => :event, :dependent => :destroy
  has_many :items, :through => :event_items
  has_many :assigned_items, :through => :event_items, :dependent => :destroy
  has_many :guests, :through => :assigned_items, :class_name => "User", :foreign_key => "user_id"  

  accepts_nested_attributes_for :event_items, :reject_if => :all_blank, :allow_destroy => true
 
 has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    header: '1000x400>'
  }

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
