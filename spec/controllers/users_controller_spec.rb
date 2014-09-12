require 'spec_helper'

describe UsersController do 

  describe 'Get #your_profile' do
    context 'when signed it' do
      it 'should render show' do
        log_in
        get :your_profile
        expect(response).to render_template(:show) 
      end
    end

    context 'without a current user' do
      it 'redirects to the root path' do
        get :your_profile
          expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'Post #create_guest' do
    @item = {"0"=>{"event_item_id"=>"87", "quantity_provided"=>"2"}}
    context 'with valid guest attributes' do
      it 'saves a new guest' do
        expect{post :create_guest, user: attributes_for(:guest)}.to change(User, :count ).by 1
      end
    end

    context 'with an existing user' do
      it 'does not create a new user' do
        FactoryGirl.create(:guest, email: 'amy@gmail.com')
        expect{post :create_guest, "user"=>{"name"=>"blahsdhjsakdhk", "guest"=>"true", "email"=>"amy@gmail.com"}}.to change(User, :count).by 0
      end
    end
  end
end

