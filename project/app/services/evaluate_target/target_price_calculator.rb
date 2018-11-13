module EvaluateTarget
  class TargetPriceCalculator
    attr_reader :pricing_base_provider
    attr_reader :locations

    def initialize(panel_provider_code, locations)
      @pricing_base_provider = PricingBaseProvider.new.create_instance(panel_provider_code)
      @locations = locations
    end

    def calculate
      pricing_base = pricing_base_provider.calculate
      price_sum = 0
      locations.each do |location|
        price_sum += Float(location[:panel_size]) * pricing_base
      end
      price_sum
    end
  end
end
