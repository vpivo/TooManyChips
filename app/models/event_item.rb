class EventItem < ActiveRecord::Base
  has_many :assigned_items ,:dependent => :destroy, :autosave => true
  belongs_to :event
  belongs_to :item 
  belongs_to :guest, :autosave => true
  validates :description, :length => { :maximum => 140 }
  validates :quantity_needed, :presence => true
  validates :quantity_needed, :numericality => {:only_integer => true, :greater_than => 0}


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

  def pecentage
    (self.quantity_assigned.to_f / self.quantity_needed.to_f).to_f * 100
  end

  def set_quantity
    if self.quantity_needed == nil || self.quantity_needed <= 0
      self.quantity_needed = 1
      self.save
    end
  end

  def to_ko
    { id: id,
      name: item.name,
      quantity: quantity_needed,
      description: description,
      guest_created: guest_created
    }
  end

end


