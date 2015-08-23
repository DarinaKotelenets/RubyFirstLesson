require_relative '../../features/support/pages/start_page'
require_relative '../../../rubymine/features/support/pages/registration_page'
require_relative '../support/pages/account_page'

Given(/^I am on Start  Page$/) do
  visit(StartPage)
end
When(/^I click register link$/) do
  @current_page.register
end
Then(/^I am on Registration Page$/) do
  #@current_page.text().should include('reg')
end

When(/^I am want to fill registration form$/) do
  visit(RegistrationPage)
end
=begin
And(/^I registed$/) do
  on(RegistrationPage).complete_order
  sleep 1
end
=end
And(/^I enter "([^"]*)" in the password field$/) do |password|
  @current_page.password = password
end

And(/^I enter "([^"]*)" in the login field$/) do |login|
  @current_page.login = login
end

And(/^I enter "([^"]*)" in the password_conf field$/) do |password_conf|
  @current_page.password_conf = password_conf
end

And(/^I enter "([^"]*)" in the firstname field$/) do |firstname|
  @current_page.firstname = firstname
end

And(/^I enter "([^"]*)" in the lastname field$/) do |lastname|
  @current_page.lastname = lastname
end

And(/^I enter "([^"]*)" in the mail field$/) do |mail|
  @current_page.mail = mail
end

And(/^I choose "([^"]*)" for interface$/) do |language|
  @current_page.language = language
end

And(/^I click button submit$/) do
  @current_page.submit
end

Then(/^I logged in as "([^"]*)"$/) do |login|
  visit(StartPage)
  @current_page.text.should include login
  #expect(on(AccountPage).user.text).to eql login
end
