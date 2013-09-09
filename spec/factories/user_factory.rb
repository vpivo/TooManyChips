FactoryGirl.define do
	factory :registered_user, class: User do
		name            "Ben Angel"
		sequence(:email) {|n| "person#{n}@example.com" }
		password "password"
		guest false
	end

	factory :guest, class: User do
		name "amy"
				sequence(:email) {|n| "guest_person#{n}@example.com" }

		guest true
	end

		factory :amy, class: User do
		name            "Amy L"
		sequence(:email) {|n| "amy_person#{n}@example.com" }
		password "password"
		guest false
	end

end



