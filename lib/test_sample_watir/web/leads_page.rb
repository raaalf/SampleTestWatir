require_relative '../../test_sample_watir/core/web_page'

module TestSampleWatir
  module Web

    class LeadsPage < TestSampleWatir::Core::WebPage

      def initialize(browser)
        super(browser)
        wait_to_load
      end

      def goto_create_lead
        new_lead_button.click
      end

      def loaded?
        loader_present? && new_lead_button.present?
      end

      #
      # page web element accessors
      #

      def new_lead_button
        @browser.link(:href => '/leads/new', :text => 'Lead')
      end

      def lead_by_name(first_name, last_name)
        @browser.link(:text, first_name+' '+last_name)
      end

    end

  end
end