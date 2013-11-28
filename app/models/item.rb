class Item < ActiveRecord::Base
	# attr_accessible :name, :suggestion, :quantity_needed, :type_id
	has_one :type, :as => :typeable
	# after_save :check_nil
	has_many :items, :through => :event_items
  has_many :events, :through => :event_items #:inverse_of => :item
  has_many :event_items, :inverse_of => :item
  validates_presence_of :name

  def check_nil
  	if self.name == nil
  		self.destroy 
  	end
  end
end
