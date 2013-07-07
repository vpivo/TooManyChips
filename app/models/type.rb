class Type < ActiveRecord::Base
  attr_accessible :name
  belongs_to :event, :polymorphic => :true
  belongs_to :item, :polymorphic => :true
end
