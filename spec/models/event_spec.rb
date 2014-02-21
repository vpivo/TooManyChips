require 'spec_helper'

describe Event do

  let(:event)          { create(:event) }
  let(:event_item)     { build(:event_item, quantity_needed: 4) }
  let(:assigned_item)  { build(:assigned_item) }           

  # it {should allow_mass_assignment_of(:name)}
  # it {should allow_mass_assignment_of(:description)}
  # it {should allow_mass_assignment_of(:date)}
  # it {should allow_mass_assignment_of(:location)}
  # it {should allow_mass_assignment_of(:image)}
  # it {should allow_mass_assignment_of(:state)}
  # it {should allow_mass_assignment_of(:city)}
  # it {should allow_mass_assignment_of(:zip)}
  # it {should allow_mass_assignment_of(:allow_guest_create)}
  # it {should allow_mass_assignment_of(:host_name)}
  # it {should allow_mass_assignment_of(:street_address)}
  # it {should allow_mass_assignment_of(:image_file_name)}
  # it {should allow_mass_assignment_of(:image_content_type)}
  # it {should allow_mass_assignment_of(:image_file_size)}
  # it {should allow_mass_assignment_of(:image_updated_at)}
  # it {should allow_mass_assignment_of(:start_time)}
  # it {should allow_mass_assignment_of(:end_time)}
  # it {should allow_mass_assignment_of(:event_type)}
  # it {should_not allow_mass_assignment_of(:user_id)}
  # it {should respond_to(:name)}
  # it {should respond_to(:description)}
  # it {should respond_to(:date)}
  # it {should respond_to(:location)}
  # it {should respond_to(:url)}
  # it {should respond_to(:user_id)}
  # it {should respond_to(:created_at)}
  # it {should respond_to(:updated_at)}
  # it {should respond_to(:image)}
  # it {should respond_to(:state)}
  # it {should respond_to(:city)}
  # it {should respond_to(:zip)}
  # it {should respond_to(:allow_guest_create)}
  # it {should respond_to(:host_name)}
  # it {should respond_to(:street_address)}
  # it {should respond_to(:image_file_name)}
  # it {should respond_to(:image_content_type)}
  # it {should respond_to(:image_file_size)}
  # it {should respond_to(:image_updated_at)}
  # it {should respond_to(:start_time)}
  # it {should respond_to(:end_time)}
  # it {should respond_to(:event_type)}
  # it { should belong_to :host }
  # it { should have_many :event_items }
  # it { should have_many(:items).through :event_items }
  # it { should have_many(:assigned_items).through :event_items }
  # it { should have_many(:guests).through :assigned_items}
  # it { should validate_presence_of(:name)}
  # it { should validate_presence_of(:date)}
  # it { should validate_presence_of(:host_name)}
  # it { should accept_nested_attributes_for(:event_items).allow_destroy true }

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

  describe "#format_date" do
    let(:event) { build(:event, date: '2020-07-26')  }
    context 'new record' do
      it 'formats event date before save' do
        expect(event.date).to eq(Date.new(2020, 7, 26))
      end

      context 'existing record' do
        it 'formats event date before save' do
          event.update_attributes!(date:'may 3, 2015')
          event.save
          expect(event.date).to eq(Chronic.parse('may 3, 2015'))
        end
      end
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