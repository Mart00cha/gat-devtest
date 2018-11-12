class LocationGroup < ApplicationRecord
  belongs_to :country
  belongs_to :panel_provider
  has_and_belongs_to_many :locations
  validates :name, presence: true, uniqueness: true
  validates :panel_provider, presence: true
  validates :country, presence: true
end
