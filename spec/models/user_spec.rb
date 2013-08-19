require 'spec_helper'

describe User do 

  subject {FactoryGirl.create(:registered_user)}
  let(:guest) {FactoryGirl.create(:guest)}
  let(:event) {build(:event)}
  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :email }
  it { should allow_mass_assignment_of :password }
  it { should have_many(:events).class_name("Event")}
  it { should have_many(:event_items)}
  it { should ensure_length_of(:password).is_at_least(6).with_short_message(/must have at least 6 characters/)}
  it { should validate_presence_of(:name)}

  describe '#new' do
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
        expect{FactoryGirl.create(:user, password: '')}.to raise_error
      end

      it 'does not set a url' do
        expect(subject.url).to eq(nil)
      end
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

    # describe ".get_contributions" do
    #   it 'return the users contributions' do
    #     expect(guest.get_contributions(event.id)).to include(assigned_item)
    #   end
    # end
  end
end



