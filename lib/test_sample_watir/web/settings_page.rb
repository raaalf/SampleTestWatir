require_relative '../../test_sample_watir/core/web_page'

module TestSampleWatir
  module Web

    class SettingsPage < TestSampleWatir::Core::WebPage

      def initialize(browser)
        super(browser)
        wait_to_load
      end

      def goto_leads_settings
        leads_button.click
        wait_until {lead_statuses_tab.present?}
      end

      def goto_lead_statuses
        lead_statuses_tab.click
      end

      def changeStatusName(old_name, new_name)
        edit = status_edit_button(old_name)
        wait_until {edit.present?}
        edit.click
        wait_until {status_name_input.exists?}
        status_name_input.set(new_name)
        save_button.click
        wait_until {status_edit_button(new_name).present?}
      end

      def loaded?
        loader_present? && leads_button.present?
      end

      #
      # page web element accessors
      #

      def leads_button
        @browser.link(:href, '/settings/leads')
      end

      def lead_statuses_tab
        @browser.link(:href, '#lead-status')
      end

      def status_name_input
        @browser.text_field(:id => 'name', :name => 'name')
      end

      def save_button
        @browser.button(:text, 'Save')
      end

      def status_edit_button(status_name)
        @browser.element(:xpath, "//div[@class='control-group item'][label//text()='#{status_name}']/div/div/button[text()='Edit']")
      end

    end

  end
end