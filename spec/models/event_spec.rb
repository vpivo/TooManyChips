require 'spec_helper'

describe Event do
  let(:event)  { build(:event) }

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

  it { should validate_presence_of :name }

  describe "set_url" do
    it "should be a url when it is saved" do
      event.save
      event.url.length.should == 22
    end
    it "should not overwrite an existing url" do
      event.save
      original_url = event.url
      event.save
      event.url.should == original_url
    end
  end
end
