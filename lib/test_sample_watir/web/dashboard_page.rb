require_relative '../../test_sample_watir/core/web_page'

module TestSampleWatir
  module Web

    class DashboardPage < TestSampleWatir::Core::WebPage

      def initialize(browser)
        super(browser)
        wait_to_load
      end

      def goto_leads
        leads_button.click
      end

      def goto_settings
        gear_button.click
        wait_until {settings_button.present?}
        settings_button.click
      end

      def loaded?
        loader_present? && leads_button.present?
      end
      #
      # page web element accessors
      #

      def leads_button
        @browser.link(:id, 'nav-leads')
      end

      def gear_button
        @browser.link(:href, '#user-dd')
      end

      def settings_button
        @browser.link(:href, '/settings/profile')
      end

    end

  end
end