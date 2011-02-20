#encoding: utf-8
Given /^a user named "([^"]*)"$/ do |user_name|
  user = User.new
  user.provider = 'twitter'
  user.uid = '1234'
  user.name = user_name
  user.save
end

When /^I identify myself as "([^"]*)"$/ do |user_name|
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = {
    'provider' => 'twitter',
    'uid' => '1234',
    'user_info' => {'name' => user_name}
  }
  within('#sign_in') do
    click_link("Identifícate con twitter")
  end
end

Then /^I get a personal message for "([^"]*)"$/ do |user_name|
  page.should have_content(user_name)
end

Then /^I am not able to sign in again$/ do
  page.should_not have_content("Identifícate con twitter")
end

