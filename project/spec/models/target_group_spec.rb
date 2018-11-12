require 'rails_helper'

RSpec.describe TargetGroup, type: :model do
  subject do
    described_class.new(
      name: 'Group name',
      external_id: 'Lorem ipsum',
      secret_code: 'Very secret secret',
      panel_provider: PanelProvider.first
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without external_id' do
    subject.external_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with duplicated external_id' do
    subject.external_id = TargetGroup.first.external_id
    expect(subject).to_not be_valid
  end

  it 'is not valid without a secret_code' do
    subject.secret_code = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a panel_provider' do
    subject.panel_provider = nil
    expect(subject).to_not be_valid
  end

  it 'is valid with a parent' do
    subject.parent = TargetGroup.first
    expect(subject).to be_valid
  end

  it 'is valid with countries' do
    subject.countries = Country.all
    expect(subject).to be_valid
  end

  it 'is valid with child_target_groups' do
    subject.child_target_groups = [TargetGroup.first, TargetGroup.last]
    expect(subject).to be_valid
  end
end
