require 'rails_helper'

RSpec.describe TargetGroupToCountry, type: :model do
  subject do
    described_class.new(target_group: TargetGroup.where(parent_id: nil).first, country: Country.first)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a target group' do
    subject.target_group = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a country' do
    subject.country = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with target groups that are not root' do
    subject.target_group = TargetGroup.where.not(parent_id: nil).first
    expect(subject).to_not be_valid
  end
end
