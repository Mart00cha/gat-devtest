module EvaluateTarget
  module PricingLogic
    class PanelOne < Base
      def calculate
        content = fetch_website_content(url)
        content.count('a') / 100
      end

      private

      def url
        'http://time.com'
      end
    end
  end
end
