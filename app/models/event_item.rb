class EventItem < ActiveRecord::Base
  after_save :check_nil
  attr_accessible :event_id, :description, :item_id, :quantity_needed, :item_attributes, :guest_created
  has_many :assigned_items ,:dependent => :destroy, :autosave => true
  belongs_to :event
  belongs_to :item 
  belongs_to :guest, :autosave => true
  validates :description, :length => { :maximum => 140 }
  validates :quantity_needed, :presence => true
  validates :quantity_needed, :numericality => {:only_integer => true, :greater_than => 0}
  accepts_nested_attributes_for :item, :reject_if => :all_blank

  def quantity_still_needed
    quant_needed = self.quantity_needed - self.quantity_assigned
    quant_needed >= 0 ? quant_needed : 0
  end

  def quantity_assigned
    self.assigned_items.map { |i| i.quantity_provided }.sum
  end

  def needed?
    self.quantity_needed > 0
  end

  private

  def pecentage
    (self.quantity_assigned.to_f / self.quantity_needed.to_f).to_f * 100
  end

  def set_quantity
    if self.quantity_needed == nil || self.quantity_needed <= 0
      self.quantity_needed = 1
      self.save
    end
  end

  def check_nil
    if self.item_id == nil
      self.destroy 
    else
      set_quantity
    end
  end

end


