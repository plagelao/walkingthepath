# encoding: utf-8

Given /^"([^"]*)" event the (next|past) week at ([^"]*)$/ do |title, time, hour|
  @date = next_week(hour)
  @date = previous_week(hour) if time == 'past'
  event = Event.new
  event.datetime = @date
  event.title = title
  event.link = 'http://Alink.es'
  event.save
end

Given /^"([^"]*)" event the next week at ([^"]*) linked to "([^"]*)"$/ do |title, hour, link|
  @date = next_week
  event = Event.new
  event.datetime = @date
  event.title = title
  event.link = link
  event.save
end

When /^I ask for the next events$/ do
  visit path_to('the homepage')
end

When /^I subscribe to the events update$/ do
  visit path_to('the atom feed')
end

Then /^the information associated to the "([^"]*)" event must be "([^"]*)"$/ do |event, link|
  within('#events') do
    find_link event
    all('a').each { |a| a[:href] == link }
  end
end

Then /^I should not see any event at all$/ do
  within('#events') do
    page.should have_content('Ningún evento')
  end
end

Then /^I must see "([^"]*)" event at ([^"]*) the next week$/ do |event, hour|
  within('#events') do
    page.should have_content(event)
    page.should have_content(hour)
    page.should have_content(@date.day.to_s)
    page.should have_content(EventDate::MONTHS[@date.month - 1])
  end
end
Then /^I must see "([^"]*)" event before "([^"]*)" event$/ do |first_event, second_event|
  within('#events') do
    all('.h2')[0].all('a')[0].text.should == first_event
    all('.h2')[1].all('a')[0].text.should == second_event
  end
end

Then /^I must receive a notification of "([^"]*)" event at ([^"]*) the next week$/ do |event, hour|
  page.should have_content(event)
  page.should have_content(hour)
  page.should have_content(@date.day.to_s)
  page.should have_content(@date.month.to_s)
end

Then /^I must see an ask for the feed option$/ do
  within('#feeds') do
    all('.feed')[0].all('a')[0][:href].should =~ Regexp.new(Regexp.escape(path_to('the atom feed')))
  end
end
