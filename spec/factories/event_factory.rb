FactoryGirl.define do

	factory :event do
		name 							"Pool Party" 
		description       "Super fun"
		location          "DBC"
		city              "San Francisco"
		zip               94117
		state             "CA"
		allow_guest_create true
		host_name         "Amy"
		street_address    "100 Broderick"
		start_time				"7pm"
		end_time          "10pm"
		event_type				"BBQ"
		date 							11/12/2016

		# factory :event_with_associations do
		# 	before_create do |event|
		# 		4.times do 
		# 			item = create(:assigned_item, user_id: 4)
		# 			event.assigned_items << item
		# 		end
		# 	end
		# end 
	end


end
