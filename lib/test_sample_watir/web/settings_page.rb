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
        wait_until {add_lead_status_button.present?}
      end

      def change_status_name(old_name, new_name)
        edit = status_edit_button(old_name)
        wait_until {edit.present?}
        edit.click
        wait_until {status_name_input(old_name).exists?}
        status_name_input(old_name).set(new_name)
        save_button(old_name).click
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

      def status_name_input(name_value)
        @browser.text_field(:id => 'name', :name => 'name', :value => name_value)
      end

      def save_button(name_value)
        @browser.element(:xpath, "//form/fieldset[div/div/input[@value='#{name_value}' and @id='name']]/div/div/button[text()='Save']")
      end

      def status_edit_button(status_name)
        @browser.element(:xpath, "//div[@class='control-group item'][label//text()='#{status_name}']/div/div/button[text()='Edit']")
      end

      def add_lead_status_button
        @browser.div(:class, 'new-named-object').div.div.element(:xpath, "//button[contains(text(), 'Add Lead Status')]")
      end

    end

  end
end