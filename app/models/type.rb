class Type < ActiveRecord::Base
  belongs_to :event, :polymorphic => :true
  belongs_to :item, :polymorphic => :true
end
