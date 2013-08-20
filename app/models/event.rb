class Event < ActiveRecord::Base
  validates_presence_of :name, :date
  attr_accessible :date, :description, :name,
  :host_provided, :location, :name, :start_time, :user_id,
  :event_items_attributes, :state, :city, :zip, :event_type, 
  :allow_guest_create, :image, :image_updated_at,
  :host_name, :type, :end_time, :street_address, :remote_image_url, 
  :image_file_name, :image_content_type, :image_file_size
  belongs_to :host, :class_name => "User", :foreign_key => 'user_id'
  has_many :event_items, :inverse_of => :event, :dependent => :destroy
  has_many :items, :through => :event_items
  has_many :assigned_items, :through => :event_items, :dependent => :destroy
  has_many :guests, :through => :assigned_items, :class_name => "User", :foreign_key => "user_id"  
  before_save :format_date
  before_create :set_url
  accepts_nested_attributes_for :event_items, :reject_if => :all_blank, :allow_destroy => true

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    header: '1000x400>'
  }



  def upcoming?
    self.date  > DateTime.now
  end

  def past?
    self.date  <= DateTime.now
  end

  private

  def get_event_type_id
    params[:event][:type_id] = event_type_id(params[:event][:type_id])
  end

  def event_type_id(name)
    type = Type.find_or_create_by_name(name.downcase.singularize)
    type.id
  end

  def set_url
    self.url ||= SecureRandom.urlsafe_base64
  end
  
  def format_date
    unless self.date.class == Time
      self.date = Chronic.parse(self.date)
    end
  end

end
