require 'rspec'
require_relative '../lib/test_sample_watir'

browser = TestSampleWatir::Core::WebBrowser.initialize_browser('chrome')

STATUS_NEW = 'New'
STATUS_EDITED = 'Edited'
LEAD_FIRST_NAME = 'TestFirst'
LEAD_LAST_NAME = 'TestLast'

RSpec.configure do |config|
  config.before(:each) { @browser = browser }

  config.after(:suite) {
    #cleaning created Lead
    begin
      dashboard_page = TestSampleWatir::Web::DashboardPage.new(browser)
      dashboard_page.goto_leads
      leads_page = TestSampleWatir::Web::LeadsPage.new(browser)
      leads_page.lead_by_name(LEAD_FIRST_NAME, LEAD_LAST_NAME).click
      lead_view_page = TestSampleWatir::Web::LeadViewPage.new(browser)
      lead_view_page.remove_lead
    rescue Exception => e
      puts 'Problem during removing created lead: '+e.message
    end
    #cleaning changed status 'New'
    begin
      dashboard_page.goto_settings
      settings_page = TestSampleWatir::Web::SettingsPage.new(browser)
      settings_page.goto_leads_settings
      settings_page.goto_lead_statuses
      if settings_page.status_edit_button(STATUS_EDITED).present?
        settings_page.change_status_name(STATUS_EDITED, STATUS_NEW)
      end
    rescue Exception => e
      puts 'Problem during changing status back: '+e.message
    end
    #closing browser
    browser.close unless browser.nil?
  }

end

describe 'Simple Base test using Watir' do

  describe 'Login into Base app' do
    it 'should start from main page' do
      main_page = TestSampleWatir::Web::BaseMainPage.new(@browser)
      main_page.open
      expect(main_page.text).to include('SALES TEAMS THAT USE BASE SELL MORE')
      main_page.goto_login
    end
    it 'on login page should log with credential' do
      login_page = TestSampleWatir::Web::LoginPage.new(@browser)
      expect(login_page.text).to include('Log in to your account')
      login_page.login_as('rafalmalski@gmail.com', 'testbase')
      dashboard_page = TestSampleWatir::Web::DashboardPage.new(@browser)
      expect(dashboard_page.text).to include('Dashboard')
    end
  end

  describe 'Creating new Lead' do
    it 'go to Leads manager' do
      dashboard_page = TestSampleWatir::Web::DashboardPage.new(@browser)
      dashboard_page.goto_leads
      leads_page = TestSampleWatir::Web::LeadsPage.new(@browser)
      expect(leads_page.new_lead_button).to exist
    end
    it 'got o lead create view' do
      leads_page = TestSampleWatir::Web::LeadsPage.new(@browser)
      leads_page.goto_create_lead
      new_lead_page = TestSampleWatir::Web::NewLeadPage.new(@browser)
      expect(new_lead_page.first_name_input).to exist
    end
    it 'create new test lead' do
      new_lead_page = TestSampleWatir::Web::NewLeadPage.new(@browser)
      expect(new_lead_page.first_name_input).to exist
      new_lead_page.fill_new_lead_data(LEAD_FIRST_NAME, LEAD_LAST_NAME)
      new_lead_page.save_button.click
    end
    it 'created lead name has to fit' do
      lead_view_page = TestSampleWatir::Web::LeadViewPage.new(@browser)
      expect(lead_view_page.lead_name.text).to eq(LEAD_FIRST_NAME+' '+LEAD_LAST_NAME)
    end
  end

  describe "Change 'New' status" do
    it 'should go to settings page' do
      dashboard_page = TestSampleWatir::Web::DashboardPage.new(@browser)
      dashboard_page.goto_settings
      settings_page = TestSampleWatir::Web::SettingsPage.new(@browser)
      expect(settings_page.text).to include('Settings')
    end
    it 'go to leads settings' do
      settings_page = TestSampleWatir::Web::SettingsPage.new(@browser)
      settings_page.goto_leads_settings
      expect(settings_page.lead_statuses_tab).to exist
      settings_page.goto_lead_statuses
      expect(settings_page.status_edit_button(STATUS_NEW)).to exist
    end
    it "change status name to 'Edit'" do
      settings_page = TestSampleWatir::Web::SettingsPage.new(@browser)
      settings_page.change_status_name(STATUS_NEW, STATUS_EDITED)
      expect(settings_page.status_edit_button(STATUS_EDITED)).to exist
    end
  end

  describe 'Checked changed status' do
    it 'check it in created Lead decsription' do
      dashboard_page = TestSampleWatir::Web::DashboardPage.new(@browser)
      dashboard_page.goto_leads
      leads_page = TestSampleWatir::Web::LeadsPage.new(@browser)
      expect(leads_page.lead_by_name(LEAD_FIRST_NAME, LEAD_LAST_NAME)).to exist
      leads_page.lead_by_name(LEAD_FIRST_NAME, LEAD_LAST_NAME).click
      lead_view_page = TestSampleWatir::Web::LeadViewPage.new(@browser)
      expect(lead_view_page.status_label.text).to eq(STATUS_EDITED)
    end
  end

end