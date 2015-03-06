require_relative '../../test_sample_watir/core/web_page'

module TestSampleWatir
  module Web

    class LoginPage < TestSampleWatir::Core::WebPage

      def initialize(browser)
        super(browser)
        wait_to_load
      end

      def login_as(email, password)
        user_email_input.set(email)
        user_password_input.set(password)
        login_button.click
      end

      def loaded?
        login_button.present?
      end

      #
      # page web element accessors
      #

      def user_email_input
        @browser.text_field(:id, 'user_email')
      end

      def user_password_input
        @browser.text_field(:id, 'user_password')
      end

      def login_button
        @browser.button(:text, 'Log in')
      end

    end

  end
end
