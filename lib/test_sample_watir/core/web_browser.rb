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
            return Watir::Browser.new(:chrome, :switches => %w[--start-maximized] )
          when 'ff'
            browser = Watir::Browser.new :firefox
            browser.window.maximize
            return browser
          when 'ie'
            browser = Watir::Browser.new :ie
            browser.window.maximize
            return browser
          else
            return Watir::Browser.new :chrome
        end
      end

    end
  end
end