require 'watir-webdriver'

module TestSampleWatir
  module Core

    class WebPage
      attr_reader :browser

      def initialize(browser)
        @browser = browser
      end

      def goto(url)
        @browser.goto url
      end

      #
      # common page methods
      #

      def current_url
        @browser.url
      end

      def text
        @browser.text
      end

      def html
        @browser.html
      end

      def title
        @browser.title
      end

      def loader_present?
        !small_loader.present?
      end

      def wait_until(timeout=10, message = nil, &block)
        @browser.wait_until(timeout, message, &block)
      end

      def save_screenshot(file_name)
        @browser.wd.save_screenshot(file_name)
      end

      def wait_to_load
        wait_until {loaded?}
      end

      def small_loader
        @browser.div(:class, 'logo-loader-small')
      end

    end
  end
end
