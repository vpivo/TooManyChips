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
		date 							Chronic.parse(11/12/2016)
		after(:create) do |event|
			event.event_items << FactoryGirl.build(:ei_cheese)
		end
	end
end

# schema

# t.string   "name"
# t.text     "description"
# t.date     "date"
# t.string   "location"
# t.string   "url"
# t.integer  "user_id"
# t.datetime "created_at",                            :null => false
# t.datetime "updated_at",                            :null => false
# t.string   "image"
# t.string   "state"
# t.string   "city"
# t.string   "zip"
# t.string   "font_color"
# t.boolean  "allow_guest_create", :default => false
# t.string   "host_name"
# t.string   "street_address"
# t.string   "image_file_name"
# t.string   "image_content_type"
# t.integer  "image_file_size"
# t.datetime "image_updated_at"
# t.time     "start_time"
# t.time     "end_time"
# t.string   "event_type"