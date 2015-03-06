require 'rspec'
require_relative '../lib/test_sample_watir'

browser = TestSampleWatir::Core::WebBrowser.initialize_browser('chrome')

RSpec.configure do |config|
  config.before(:each) { @browser = browser }

  config.after(:suite) {
    begin
    #cleaning created Lead
    dashboard_page = TestSampleWatir::Web::DashboardPage.new(browser)
    dashboard_page.goto_leads
    leads_page = TestSampleWatir::Web::LeadsPage.new(browser)
    leads_page.lead_by_name('TestFirst', 'TestLast').click
    lead_view_page = TestSampleWatir::Web::LeadViewPage.new(browser)
    lead_view_page.remove_lead
    #cleaning changed status 'New'
    dashboard_page.goto_settings
    settings_page = TestSampleWatir::Web::SettingsPage.new(browser)
    settings_page.goto_leads_settings
    settings_page.goto_lead_statuses
    if settings_page.status_edit_button('Edited').present?
      settings_page.changeStatusName('Edited', 'New')
      settings_page.status_edit_button('New').should exist
    end
    rescue
      puts 'problem during cleaning'
    end
    #closing browser
    browser.close unless browser.nil?
  }

end

describe 'Simple Base test using Watir' do

  describe 'Start from Base main page' do
    it 'which should contains marketing text' do
      main_page = TestSampleWatir::Web::BaseMainPage.new(@browser)
      main_page.open
      main_page.text.should include('SALES TEAMS THAT USE BASE SELL MORE')
      main_page.goto_login
    end
  end

  describe 'On login page' do
    it 'try to login' do
      login_page = TestSampleWatir::Web::LoginPage.new(@browser)
      login_page.text.should include('Log in to your account')
      login_page.login_as('rafalmalski@gmail.com', 'testbase')
    end
  end

  describe 'After login Dashboard page will be opened' do
    it 'go to Leads manager' do
      dashboard_page = TestSampleWatir::Web::DashboardPage.new(@browser)
      dashboard_page.text.should include('Dashboard')
      dashboard_page.goto_leads
    end
  end

  describe 'Go to Leads' do
    it 'where we should be able to create new Lead' do
      leads_page = TestSampleWatir::Web::LeadsPage.new(@browser)
      leads_page.new_lead_button.should exist
      leads_page.goto_create_lead
    end
  end

  describe 'On New Lead' do
    it 'create new test lead' do
      new_lead_page = TestSampleWatir::Web::NewLeadPage.new(@browser)
      new_lead_page.first_name_input.should exist
      new_lead_page.fill_new_lead_data('TestFirst', 'TestLast')
      new_lead_page.save_button.click
    end
  end

  describe 'Successful creation' do
    it 'should end on lead view page' do
      lead_view_page = TestSampleWatir::Web::LeadViewPage.new(@browser)
      lead_view_page.lead_name.text.should equal?('TestFirst TestLast')
    end
  end

  describe 'Look for Lead statuses in settings' do
    it 'should show statuses tab' do
      dashboard_page = TestSampleWatir::Web::DashboardPage.new(@browser)
      dashboard_page.goto_settings
      settings_page = TestSampleWatir::Web::SettingsPage.new(@browser)
      settings_page.text.should include('Settings')
      settings_page.goto_leads_settings
      settings_page.lead_statuses_tab.should exist
    end
    it 'find specific status' do
      settings_page = TestSampleWatir::Web::SettingsPage.new(@browser)
      settings_page.goto_lead_statuses
      settings_page.status_edit_button('New').should exist
    end
    it 'change status name' do
      settings_page = TestSampleWatir::Web::SettingsPage.new(@browser)
      settings_page.changeStatusName('New', 'Edited')
      settings_page.status_edit_button('Edited').should exist
    end
  end

  describe 'Go to Leads' do
    it 'new lead should be present in leads list' do
      dashboard_page = TestSampleWatir::Web::DashboardPage.new(@browser)
      dashboard_page.goto_leads
      leads_page = TestSampleWatir::Web::LeadsPage.new(@browser)
      leads_page.lead_by_name('TestFirst', 'TestLast').should exist
    end
    it 'on Lead view we should have new status' do
      leads_page = TestSampleWatir::Web::LeadsPage.new(@browser)
      leads_page.lead_by_name('TestFirst', 'TestLast').click
      lead_view_page = TestSampleWatir::Web::LeadViewPage.new(@browser)
      lead_view_page.status_label.text.should equal?('Edited')
    end
  end

end