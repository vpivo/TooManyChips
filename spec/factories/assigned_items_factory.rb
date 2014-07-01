FactoryGirl.define do

  factory :assigned_item do 
    event_item_id 1
    quantity_provided          2
    event_id 1
    association :event_item
    
    
  end

  factory :assigned_item_with_user, class: AssignedItem do 
    quantity_provided          2
    association :event_item
    event_id 1
    after(:create) do |ai| 
      guest = FactoryGirl.build(:guest)
      ai.guest_id = guest.id
      ai.save
    end
  end
end



