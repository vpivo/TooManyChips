require 'spec_helper'

describe AssignedItem do

  let(:guest)          { create(:guest) }
  let(:assigned_item)  { build(:assigned_item, user_id: guest.id, event_item_id: event_item.id) }
  let(:event_item)     { create(:event_item, quantity_needed: 12) }
  let(:event)          { create(:event) }

  it { should belong_to :event_item }
  it { should belong_to :guest }
  it { should validate_numericality_of :quantity_provided}
  it { should_not allow_value(-1).for :quantity_provided }
  it { should_not allow_value("string").for :quantity_provided }
  it { should validate_presence_of :quantity_provided }

  it 'belongs to guest' do
    expect(assigned_item.guest).to eq(guest)
  end

  it "should cause an event_item's quant needed to change after it saves" do
    item = create(:assigned_item, quantity_provided: 12, user_id: guest.id)
    event_item.assigned_items << item
    event_item.quantity_still_needed.should == 0
  end

  # it "increases quanity provided on a duplicate record instead of creating another" do
  #   guest.assigned_items << build(:assigned_item, quantity_provided: 4, user_id: guest.id )
  #   guest.assigned_items << build(:assigned_item, quantity_provided: 4, user_id: guest.id )
  #   expect(guest.assigned_items.first.quantity_provided).to eq(8)
  # end

  # it "delete duplicate items" do
  #   guest.assigned_items << build(:assigned_item, quantity_provided: 4, user_id: guest.id )
  #   guest.assigned_items << build(:assigned_item, quantity_provided: 4, user_id: guest.id )
  #   expect(guest.assigned_items.length).to eq(1)
  # end

  it "does not save if quantity provided is 0" do
    expect(build(:assigned_item, quantity_provided: 0)).to_not be_valid
  end


end
