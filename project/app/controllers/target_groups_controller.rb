class TargetGroupsController < ApplicationController
  def index
    country = Country.find_by(code: params[:country_code])
    if country.present?
      panel_provider = PanelProvider.find(country.panel_provider_id)
      target_groups = find_all_matching_target_groups(country.id, panel_provider.id)
      render json: target_groups, status: :ok
    else
      render json: { error: 'Bad parameter' }, status: :bad_request
    end
  end

  private

  def find_all_matching_target_groups(country_id, panel_provider_id)
    root_groups = TargetGroup.joins(:countries).where(countries: { id: country_id })
    target_groups = root_groups
    root_groups.each do |group|
      target_groups += extract_children(group)
    end
    target_groups = target_groups.select { |group| group.panel_provider.id == panel_provider_id }
  end

  def extract_children(group)
    groups = group.child_target_groups
    unless group.child_target_groups.empty?
      group.child_target_groups.each do |child|
        groups += extract_children(child)
      end
    end
    groups
  end
end
