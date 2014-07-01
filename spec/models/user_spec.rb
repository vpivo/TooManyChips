require 'spec_helper'

describe User do 

  subject {create(:registered_user)}
  let(:guest) {create(:guest)}
  let(:event) {build(:event)}
  let(:assigned_item) {create(:assigned_item)}
  let(:event_item) {create(:event_item, id: '1')}

  describe '#create' do
    context 'guest' do
      it 'should set the url' do
        expect(guest.url.length).to eq(22) 
      end

      it 'allows creation without a password' do
        expect(guest.password).to eq(nil)
      end
    end

    context 'registered user' do
      it 'does not allows creation without a password' do
        expect{create(:user, password: '')}.to raise_error
      end

      it 'does not set a url' do
        expect(subject.url).to eq(nil)
      end
    end
  end


  describe '#add_items' do 
    context 'with new items' do
      it ' increases the users assigned items count by one' do
        assigned_item_as_json = [{"name"=>"Centerpiece", "description"=>"Velit ut vitae quam omnis necessitatibus.", "id"=>1, "amountPromised"=>0, "quantity"=>9, "amountToBring"=>3, "eventId"=>50, "stillNeeded"=>nil}]
        expect{subject.add_items(assigned_item_as_json)}.to change(subject.assigned_items, :count ).by 1
      end
    end
  end

  describe '#duplicate_item?' do 
    it 'returns true if the user has already agreed to bring that item' do
      subject.assigned_items << assigned_item
      subject.save!
      expect(subject.duplicate_item?(assigned_item)).to be(true)
    end

    it 'returns false if the user has not agreed to bring that item' do
      expect(subject.duplicate_item?(assigned_item)).to be(false)
    end
  end

  describe ".events" do
    it 'returns the users hosted events' do
      subject.events << event
      expect(subject.events).to include(event)
    end
  end

  context 'with assigned items' do
    let(:event_item) {create(:event_item, event_id: event.id)}
    let(:assigned_item) { create(:assigned_item, event_item_id: event_item.id, user_id: guest.id) }

    before do 
      guest.assigned_items << assigned_item
    end

    describe '.assigned_items' do
      it 'returns users assigned items' do
        expect(guest.assigned_items).to include(assigned_item)
      end
    end

    describe ".get_contributions" do
      it 'return the users contributions' do
        event = create(:event)
        guest = create(:guest, email: 'joe@test.com')
        ei = create(:event_item, event: event)
        ai = create(:assigned_item, guest: guest, event_item: ei)
        expect(guest.get_contributions(event.id)).to include(ai)
      end
    end
  end
end



