# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
items = %w{ Plates-Luncheon/Dinner Plates
Plates-Cake
Napkins
Napkins
Cups
Forks
Spoons
Knives
Tableclothes
Glasses
Serving-Trays
Serving-Utensils
Doilies
Candy
BottleOpener
Coffee-Pot
Tea-Pot
Centerpiece
Balloons
Streamers
Table-Sprinkles
cheese
pizza
baseball
bats
gloves
grill
ribs
BBQ-sauce
Rubber Stamps}

events = %w{
  bbq
  pool
  potluck
  dinner
  birthday
  babyshower
}

30.times do
  User.create(email: Faker::Internet.email , password: "password" , name: Faker::Name.name )
end

40. times do 
  Item.create(suggestion: "nothing yet!", name: items.sample )
end

25.times do
  User.create(email: Faker::Internet.email, name: Faker::Name.name , url: SecureRandom.urlsafe_base64, guest: true)
end

25.times do 
  event= Event.create(name: events.sample, description: "Awesome Party!", date: Chronic.parse("january 15th 2015"), location: "#{Faker::Name.name}'s House", 
    user_id: 1 + rand(20), state: "CA", city: "San Franciso", zip: "94117", 
    font_color: "0", allow_guest_create: true, 
    host_name: "amy", street_address: "100 Broderick apt 505", 
    start_time: Time.new(800), end_time: Time.new(800), event_type: "BBQ")
  10.times do
    event_item = EventItem.create(event_id: event.id, description: Faker::Lorem.sentence(word_count = 4), item_id: 1 + rand(40), quantity_needed: 6 + rand(20))
    2.times do
      AssignedItem.create(event_item_id: event_item.id , quantity_provided: rand(6), user_id: 1 + rand(20)  ) 
    end
  end
  event.save!
end

