require 'spec_helper'

describe Event do

  let(:event)          { create(:event) }
  let(:event_item)     { build(:event_item, quantity_needed: 4) }
  let(:assigned_item)  { build(:assigned_item) }           

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
    pending
    context 'new record' do
      it 'formats event date before save' do
        expect(event.date).to eq(Date.new(2020, 7, 26))
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