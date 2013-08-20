FactoryGirl.define do
	factory :event_item do
		quantity_needed           2
		description               "cold"
		event_id 1
		guest_created             false
	end

	factory :ai_event_item, class: EventItem do
		quantity_needed           2
		description               "cold"
		event_id 1
		guest_created             false
		after(:create) do |ei|
			ai = FactoryGirl.build(:assigned_item_with_user)
			ei.assigned_items << ai
		end
	end
end
