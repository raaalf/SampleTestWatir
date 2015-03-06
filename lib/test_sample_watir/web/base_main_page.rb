require_relative '../../test_sample_watir/core/web_page'

module TestSampleWatir
  module Web

    class BaseMainPage < TestSampleWatir::Core::WebPage

      def initialize(browser)
        super(browser)
      end

      def open
        goto('https://getbase.com/')
        wait_to_load
      end

      def goto_login
        login_button.click
      end

      def loaded?
        login_button.exists?
      end

      #
      # page web element accessors
      #

      def login_button
        @browser.link(:text, 'Login')
      end
    end

  end
end