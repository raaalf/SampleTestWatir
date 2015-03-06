require_relative '../../test_sample_watir/core/web_page'

module TestSampleWatir
  module Web

    class LeadViewPage < TestSampleWatir::Core::WebPage

      def initialize(browser)
        super(browser)
        wait_to_load
      end

      def loaded?
        loader_present? && status_label.present?
      end

      def remove_lead
        delete_button.click
        wait_until {remove_confirmation.present?}
        remove_confirmation.click
      end

      #
      # page web element accessors
      #

      def lead_name
        @browser.span(:class, 'detail-title')
      end

      def status_label
        @browser.span(:class, 'lead-status')
      end

      def delete_button
        @browser.link(:class, 'btn delete')
      end

      def remove_confirmation
        @browser.link(:text, 'Remove')
      end

    end

  end
end