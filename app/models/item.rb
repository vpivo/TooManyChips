class Item < ActiveRecord::Base
  has_one :type, :as => :typeable
  has_many :items, :through => :event_items
  has_many :events, :through => :event_items 
  has_many :event_items, :inverse_of => :item
  validates_presence_of :name

end
