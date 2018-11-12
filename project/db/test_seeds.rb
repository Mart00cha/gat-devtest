PANEL_PROVIDERS_CODES = %w[times_a 10_arrays times_html].freeze

COUNTRIES = [
  { code: 'PL', panel_provider_code: 'times_a' },
  { code: 'US', panel_provider_code: '10_arrays' },
  { code: 'UK', panel_provider_code: 'times_html' }
].freeze

LOCATIONS = [
  { name: 'New York', location_group_names: %w[East West] },
  { name: 'Los Angeles', location_group_names: %w[West] },
  { name: 'Chicago', location_group_names: %w[South] },
  { name: 'Houston', location_group_names: %w[East] },
  { name: 'Philadelphia', location_group_names: %w[East] },
  { name: 'Phoenix', location_group_names: %w[South] },
  { name: 'San Antonio', location_group_names: %w[West] },
  { name: 'San Diego', location_group_names: %w[West] },
  { name: 'Dallas', location_group_names: %w[West] },
  { name: 'San Jose', location_group_names: %w[West] },
  { name: 'Austin', location_group_names: %w[South] },
  { name: 'Jacksonville', location_group_names: [] },
  { name: 'San Francisco', location_group_names: %w[South] },
  { name: 'Indianapolis', location_group_names: %w[East South] },
  { name: 'Columbus', location_group_names: %w[South] },
  { name: 'Fort Worth', location_group_names: %w[South] },
  { name: 'Charlotte', location_group_names: %w[South] },
  { name: 'Detroit', location_group_names: %w[West] },
  { name: 'El Paso', location_group_names: [] },
  { name: 'Seattle', location_group_names: [] }
].freeze

LOCATION_GROUPS = [
  { name: 'East', country_code: 'PL', panel_provider_code: 'times_a',
    location_names: ['New York', 'Houston', 'Philadelphia', 'Indianapolis'] },
  { name: 'West', country_code: 'US', panel_provider_code: '10_arrays',
    location_names: ['New York', 'Los Angeles', 'San Jose', 'Detroit',
                     'San Antonio', 'San Diego', 'Dallas'] },
  { name: 'North', country_code: 'UK', panel_provider_code: 'times_html',
    location_names: [] },
  { name: 'South', country_code: 'US', panel_provider_code: 'times_html',
    location_names: ['Phoenix', 'San Francisco', 'Columbus', 'Indianapolis',
                     'Chicago', 'Austin', 'Fort Worth', 'Charlotte'] }
].freeze

PANEL_PROVIDERS_CODES.each do |panel_provider_code|
  PanelProvider.create!(code: panel_provider_code)
end

COUNTRIES.each do |country|
  Country.create!(
    code: country.fetch(:code),
    panel_provider: PanelProvider.find_by!(code: country.fetch(:panel_provider_code))
  )
end

LOCATION_GROUPS.each do |group|
  LocationGroup.create!(
    name: group.fetch(:name),
    country: Country.find_by!(code: group.fetch(:country_code)),
    panel_provider: PanelProvider.find_by!(code: group.fetch(:panel_provider_code))
  )
end

LOCATIONS.each do |location|
  current_location = Location.create!(
    name: location.fetch(:name),
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64)
  )
  location.fetch(:location_group_names).each do |group|
    current_location.location_groups << LocationGroup.find_by!(name: group)
  end
end

LOCATION_GROUPS.each do |group|
  current_group = LocationGroup.find_by!(name: group.fetch(:name))
  group.fetch(:location_names).each do |location|
    current_group.locations << Location.find_by!(name: location)
  end
end
