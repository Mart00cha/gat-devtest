class Country < ApplicationRecord
  belongs_to :panel_provider
  has_many :target_group_to_countries
  has_many :locations
  has_many :target_groups, through: :target_group_to_countries

  validates :code, presence: true, uniqueness: true
  validates :panel_provider, presence: true
end
