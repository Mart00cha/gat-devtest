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

  def evaluate
    unless validate_evaluate_params
      render json: { error: 'Bad parameter' }, status: :bad_request
      return
    end

    country = Country.find_by(code: params[:country_code])
    panel_provider = PanelProvider.find_by(id: country.panel_provider_id)
    price_calculator = EvaluateTarget::TargetPriceCalculator.new(panel_provider.code, params[:locations])
    final_price = price_calculator.calculate

    render json: final_price, status: :ok
  end

  private

  def validate_evaluate_params
    validate_keys &&
      validate_country_param &&
      validate_target_group_param &&
      validate_location_param
  end

  def validate_keys
    %i[country_code target_group_id locations].all? { |k| params.key? k }
  end

  def validate_country_param
    country = Country.find_by(code: params[:country_code])
    return false unless country.present?

    true
  end

  def validate_target_group_param
    target_group = TargetGroup.find_by(external_id: params[:target_group_id])
    return false unless target_group.present?

    true
  end

  def validate_location_param
    return false unless params[:locations].is_a?(Array)

    params[:locations].each do |location|
      return false unless number?(location[:panel_size])
      return false unless Location.find_by(external_id: location[:id]).present?
    end
    true
  end

  def number?(param)
    begin
      panel_size = Float(param)
    rescue ArgumentError
      return false
    end
    return false unless panel_size.is_a? Numeric

    true
  end

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
