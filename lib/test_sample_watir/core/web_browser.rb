require 'watir-webdriver'

module TestSampleWatir
  module Core

    module WebBrowser
      #
      # using string name of Browser we choose proper driver
      #
      def self.initialize_browser(browser_type)
        case browser_type
          when 'chrome'
            return Watir::Browser.new :chrome
          when 'ff'
            return Watir::Browser.new :firefox
          when 'ie'
            return Watir::Browser.new :ie
          else
            return Watir::Browser.new :chrome
        end
      end

    end
  end
end