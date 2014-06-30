class Event < ActiveRecord::Base
  validates_presence_of :name, :date, :host_name
  belongs_to :host, :class_name => "User", :foreign_key => 'user_id'
  has_many :event_items, :dependent => :destroy
  has_many :items, :through => :event_items
  has_many :assigned_items, :through => :event_items, :dependent => :destroy
  has_many :guests, :through => :assigned_items, :class_name => "User", :foreign_key => "user_id"  
  before_save :format_date
  before_create :set_url

  has_attached_file :image, styles: {thumb: '100x100>', square: '200x200#', header: '1000x400>'}


  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]


  def to_ko
    {
      id: id,
      date: date,
      start_time: start_time,
      end_time: end_time,
      location: location,
      city: city,
      allow_guest_create: allow_guest_create,
      state: state,
      zip: zip,
      host_name: host_name,
      name: name,
      description: description,
      image: image.url, 
      items: event_items.collect { |item| item.to_ko }
    }
  end

  def upcoming?
    self.date  > DateTime.now
  end

  def past?
    self.date  <= DateTime.now
  end

  private

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
