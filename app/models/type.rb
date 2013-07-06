class Type < ActiveRecord::Base
 attr_accessible :name
 belongs_to :event, :polymorphic => :true
 belongs_to :item, :polymorphic => :true
 before_save :sanitize
 
 def sanitize
  self.name = self.name.downcase.singularize
  self.save
 end
end
