require 'rails_helper'

RSpec.describe Country, type: :model do
  subject do
    described_class.new(panel_provider: PanelProvider.first, code: 'Lorem ipsum')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a panel provider' do
    subject.panel_provider = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a code' do
    subject.code = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with duplicated code' do
    subject.code = Country.first.code
    expect(subject).to_not be_valid
  end
end
