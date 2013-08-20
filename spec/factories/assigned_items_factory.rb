FactoryGirl.define do

	factory :assigned_item do 
		quantity_provided          2
	end

	factory :assigned_item_with_user, class: AssignedItem do 
		quantity_provided          2
		association :event_item
		after(:create) do |ai| 
			guest = FactoryGirl.build(:guest)
			ai.guest_id = guest.id
			ai.save
		end
	end
end



