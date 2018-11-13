require 'json'

module EvaluateTarget
  module PricingLogic
    class PanelTwo < Base
      def calculate
        content = fetch_website_content(url)
        json = JSON.parse(content)
        calculate_arrays(json)
      end

      private

      def calculate_arrays(json)
        sum = 0
        json = json.values if json.is_a?(Hash)
        json.each do |value|
          sum += 1 if value.is_a?(Array) && value.count > 10
          sum += calculate_arrays(value) if value.is_a?(Hash) || value.is_a?(Array)
        end
        sum
      end

      def url
        'http://openlibrary.org/search.json?q=the+lord+of+the+rings'
      end
    end
  end
end
