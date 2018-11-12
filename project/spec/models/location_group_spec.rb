require 'rails_helper'

RSpec.describe LocationGroup, type: :model do
  subject do
    described_class.new(panel_provider: PanelProvider.first, name: 'Lorem ipsum', country: Country.first)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a panel provider' do
    subject.panel_provider = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with duplicated name' do
    subject.name = LocationGroup.first.name
    expect(subject).to_not be_valid
  end

  it 'is not valid without country' do
    subject.country = nil
    expect(subject).to_not be_valid
  end

  it 'is valid with locations' do
    subject.locations = [Location.first, Location.last]
    expect(subject).to be_valid
  end
end
