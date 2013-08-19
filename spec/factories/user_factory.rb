FactoryGirl.define do
	factory :registered_user, class: User do
		name            "Ben Angel"
		email   'ben1dfdfsfds@ben.com'
		password "password"
		guest false
	end

	factory :guest, class: User do
		name "amy"
		email 'amy1@amy.com'
		guest true
	end

end



