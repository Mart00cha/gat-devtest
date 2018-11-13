module EvaluateTarget
  class PricingBaseProvider
    def create_instance(panel_provider_code)
      case panel_provider_code
      when 'times_a'
        PricingLogic::PanelOne.new
      when '10_arrays'
        PricingLogic::PanelTwo.new
      when 'times_html'
        PricingLogic::PanelThree.new
      end
    end
  end
end
