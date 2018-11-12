class LocationsController < ApplicationController
  def index
    country = Country.find_by(code: params[:country_code])
    if country.present?
      panel_provider = PanelProvider.find(country.panel_provider_id)
      locations = find_all_matching_locations(country.id, panel_provider.id)
      render json: locations, status: :ok
    else
      render json: { error: 'Bad parameter' }, status: :bad_request
    end
  end

  private

  def location_params
    params.permit(:country_code)
  end

  def find_all_matching_locations(country_id, panel_provider_id)
    location_groups = LocationGroup.where(
      country_id: country_id,
      panel_provider_id: panel_provider_id
    )

    locations = []
    location_groups.each do |group|
      locations << group.locations
    end

    locations.uniq
  end
end
