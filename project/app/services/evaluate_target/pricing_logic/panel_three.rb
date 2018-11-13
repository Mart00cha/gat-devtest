module EvaluateTarget
  module PricingLogic
    class PanelThree < Base
      def calculate
        content = fetch_website_content(url)
        doc = Nokogiri::HTML(content)
        doc.search('*').count / 100
      end

      private

      def url
        'http://time.com'
      end
    end
  end
end
