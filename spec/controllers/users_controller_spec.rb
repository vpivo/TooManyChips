require 'spec_helper'

describe UsersController do 
	def log_in(fabricator=nil)
		user = create(fabricator || :registered_user)
		log_in_user(user)
		user
	end

	def log_in_user(user)
		session[:id] = user.id
	end

	describe 'Get #your_profile' do
		context 'when signed it' do
			it 'should render show' do
				log_in
				get :your_profile
				expect(response).to render_template(:show) 
			end
		end
	end

	describe 'Get #guest' do
		it 'should render show' do
			get :guest
			expect(response).to render_template(:show) 
		end
	end

	describe 'Post #create' do
		@item = {"0"=>{"event_item_id"=>"87", "quantity_provided"=>"2"}}
		context 'with valid guest attributes' do
			it 'saves a new guest' do
				expect{post :create, user: attributes_for(:guest)}.to change(User, :count ).by 1
			end

			it 'redirects to users#show' do
				post :create, user: attributes_for(:guest)
				expect(response).to redirect_to guest_url(assigns(:user).url)
			end

			context 'with assigned items'
			it 'redirects to users#show' do
				post :create, "user"=>{"assigned_items_attributes"=>{"0"=>{"event_item_id"=>"87", "quantity_provided"=>"2"}}, "name"=>"blahsdhjsakdhk", "guest"=>"true", "email"=>"baldsjdkaldsja@gmail.com"}
				expect(response).to redirect_to guest_url(assigns(:user).url)
			end

			it 'creates assigned_items for the user' do
				expect{post :create, "user"=>{"assigned_items_attributes"=>{"0"=>{"event_item_id"=>"87", "quantity_provided"=>"2"}}, "name"=>"blahsdhjsakdhk", "guest"=>"true", "email"=>"baldsjdkaldsja@gmail.com"}}.to change(AssignedItem, :count).by 1
			end
		end

		context 'with an existing user' do
			it 'does not create a new user' do
				FactoryGirl.create(:guest)
				expect{post :create, "user"=>{"assigned_items_attributes"=>{"0"=>{"event_item_id"=>"87", "quantity_provided"=>"2"}}, "name"=>"blahsdhjsakdhk", "guest"=>"true", "email"=>"amy1@amy.com"}}.to change(User, :count).by 0
			end
		end

		it 'redirects to users#show' do
			post :create, "user"=>{"assigned_items_attributes"=>{"0"=>{"event_item_id"=>"87", "quantity_provided"=>"2"}}, "name"=>"blahsdhjsakdhk", "guest"=>"true", "email"=>"amy1@amy.com"}
			expect(response).to redirect_to guest_url(assigns(:user).url)
		end
	end
end

