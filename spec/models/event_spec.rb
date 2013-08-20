require 'spec_helper'

describe Event do
  let(:event)          { create(:event) }
  let(:event_item)     { build(:event_item, quantity_needed: 4) }
  let(:assigned_item)  { build(:assigned_item) }           

  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :date  }
  it { should allow_mass_assignment_of :description }
  it { should allow_mass_assignment_of :host_provided }
  it { should allow_mass_assignment_of :location }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :event_items_attributes }
  it { should belong_to :host }
  it { should have_many :event_items }
  it { should have_many(:items).through :event_items }
  it { should have_many(:assigned_items).through :event_items }
  it { should have_many(:guests).through :assigned_items}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:date)}
  it { should accept_nested_attributes_for(:event_items).allow_destroy true }

  describe "set_url" do
    it "should be a url when it is saved" do
      expect(event.url.length).to eq(22)
    end

    it "should not overwrite an existing url" do
      original_url = event.url
      event.save
      expect(event.url).to eq(original_url)
    end
  end

  describe '#upcoming?' do 
    it 'returns true if date is in the future' do
      event = build(:event, date: '2020-07-26') 
      expect(event.upcoming?).to eq(true)
    end

    it 'returns false if the is in the past' do 
      event = build(:event, date: '2002-07-26') 
      expect(event.upcoming?).to eq(false)
    end
  end

  describe '.guests' do
    context 'without guests' do
      it 'returns an empty array' do 
        expect(event.guests).to eq([])
      end
    end

    context 'with guests' do
      it 'returns guests' do
        event = create(:event)
        guest = create(:guest)
        ei = create(:event_item, event: event)
        ai = create(:assigned_item, guest: guest, event_item: ei)
        expect(event.guests).to include(guest)
      end 
    end
  end
end