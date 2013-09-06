class AssignedItem < ActiveRecord::Base
  attr_accessible :event_item_id, :quantity_provided, :user_id
  validates :quantity_provided, :presence => true
  validates :quantity_provided, :numericality => {:only_integer => true, :greater_than => 0}
  belongs_to :event_item
  belongs_to :guest, class_name: 'User', foreign_key: 'user_id'
  
  # before_create :check_for_duplicate

  # def check_for_duplicate
  #   unless duplicate_item.nil?
  #     self.quantity_provided += duplicate_item.quantity_provided
  #     duplicate_item.destroy
  #   end
  # end

  # private

  # def duplicate_item
  #   self.guest.assigned_items.find_by_event_item_id(self.event_item_id)
  # end
end
