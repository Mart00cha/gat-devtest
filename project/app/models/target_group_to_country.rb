class TargetGroupToCountry < ApplicationRecord
  belongs_to :country
  belongs_to :target_group
  validates :country, presence: true
  validates :target_group, presence: true, root: true
end
