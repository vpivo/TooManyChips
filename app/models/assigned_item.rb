class AssignedItem < ActiveRecord::Base
  validates :quantity_provided, :presence => true
  validates :quantity_provided, :numericality => {:only_integer => true, 
    :greater_than => 0}
    belongs_to :event_item
    belongs_to :event
    belongs_to :guest, class_name: 'User', foreign_key: 'user_id'

  def to_ko
    { id: id,
      event_item_id: event_item_id,
      quantity_provided: quantity_provided,
      user_id: guest.id
    }
  end

end


