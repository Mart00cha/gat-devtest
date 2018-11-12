class TargetGroup < ApplicationRecord
  has_many :target_group_to_countries
  has_many :countries, through: :target_group_to_countries
  has_many :child_target_groups, class_name: 'TargetGroup', foreign_key: :parent_id
  belongs_to :parent, class_name: 'TargetGroup', foreign_key: :parent_id, optional: true
  belongs_to :panel_provider

  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  validates :secret_code, presence: true
  validates :panel_provider, presence: true

  def root?
    parent.nil?
  end
end
