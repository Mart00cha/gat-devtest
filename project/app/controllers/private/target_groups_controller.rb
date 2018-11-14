class Private::TargetGroupsController < TargetGroupsController
  before_action :authenticate_request
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
    country.present?
  end

  def validate_target_group_param
    target_group = TargetGroup.find_by(external_id: params[:target_group_id])
    target_group.present?
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
    panel_size = Float(param)
    panel_size.is_a? Numeric
  rescue ArgumentError
    false
  end
end
