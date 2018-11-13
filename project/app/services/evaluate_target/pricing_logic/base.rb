require 'open-uri'

module EvaluateTarget
  module PricingLogic
    class Base
      def calculate
        raise NotImplementedError, 'Implement this method in a child class'
      end

      private

      def url
        raise NotImplementedError, 'Implement this method in a child class'
      end

      def fetch_website_content(url)
        URI.parse(url).open.read
      end
    end
  end
end
