require_relative '../../test_sample_watir/core/web_page'

module TestSampleWatir
  module Web

    class NewLeadPage < TestSampleWatir::Core::WebPage

      def initialize(browser)
        super(browser)
        wait_to_load
      end

      def loaded?
        loader_present? && first_name_input.present?
      end

      def fill_new_lead_data(first_name, last_name)
        first_name_input.set(first_name)
        last_name_input.set(last_name)
        company_name_input.set('TestCompany')
        title_input.set('Mr')
        unless selected_status.text.eql?('New')
          select_status('New')
        end
        email_input.set('test@mail.com')
        mobile_input.set('123 123 123')
        phone_input.set('12 333 44 55')
        street_input.set('TestStr 1')
        city_input.set('Krakow')
        region_input.set('Lesser Poland')
        zip_input.set('30-069')
        select_country('Poland')
      end

      #
      # page web element accessors
      #
      def save_button
        @browser.button(:text, 'Save')
      end

      def first_name_input
        @browser.text_field(:id, 'lead-first-name')
      end

      def last_name_input
        @browser.text_field(:id, 'lead-last-name')
      end

      def company_name_input
        @browser.text_field(:id, 'lead-company-name')
      end

      def title_input
        @browser.text_field(:id, 'lead-title')
      end

      def selected_status
        @browser.div(:class, 'status-select').div.div.link(:class, 'chzn-single').span
      end

      def select_status(value)
        selected_status.click
        elem = @browser.div(:class, 'status-select').div.div.ul(:class, 'chzn-results').li(:text, value)
        elem.click unless elem == nil
      end

      def email_input
        @browser.text_field(:id, 'lead-email')
      end

      def mobile_input
        @browser.text_field(:id, 'lead-mobile')
      end

      def phone_input
        @browser.text_field(:id, 'lead-phone')
      end

      def street_input
        @browser.text_field(:id, 'lead-street')
      end

      def city_input
        @browser.text_field(:id, 'lead-city')
      end

      def region_input
        @browser.text_field(:id, 'lead-region')
      end

      def zip_input
        @browser.text_field(:id, 'lead-zip')
      end

      def selected_country
        @browser.div(:class, 'controls inline country_select').div.link.span
      end

      def select_country(country)
        selected_country.click
        elem = @browser.div(:class, 'controls inline country_select').div.ul(:class, 'chzn-results').li(:text, country)
        elem.click unless elem == nil
      end

    end

  end
end