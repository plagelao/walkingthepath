# encoding: utf-8
MONTHS = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
Given /^"([^"]*)" event the (next|past) week at ([^"]*)$/ do |event, time, hour|
  @event_date = DateTime.now + 7 if time == 'next'
  @event_date = DateTime.now - 7 if time == 'past'
  event = Event.create(@event_date.year, MONTHS[@event_date.month - 1], @event_date.day, hour, event, '#')
  event.save
end

Given /^"([^"]*)" event the next week at ([^"]*) linked to "([^"]*)"$/ do |event, hour, link|
  @event_date = DateTime.now + 7
  event = Event.create(@event_date.year, MONTHS[@event_date.month - 1], @event_date.day, hour, event, link)
  event.save
end

When /^I ask for the next events$/ do
  visit path_to('the homepage')
end

When /^I ask for the next events as atom feed$/ do
  visit path_to('the atom feed')
end

Then /^the information associated to the "([^"]*)" event must be "([^"]*)"$/ do |event, link|
  with_scope('#events') do
    find_link event
    all('a').each { |a| a[:href] == link }
  end
end

Then /^I should not see any event at all$/ do
  with_scope('#events') do
    page.should have_content('Ningún evento')
  end
end

Then /^I must see "([^"]*)" event at ([^"]*) the next week$/ do |event, hour|
  with_scope('#events') do
    page.should have_content(event)
    page.should have_content(hour)
    page.should have_content(@event_date.day.to_s)
    page.should have_content(MONTHS[@event_date.month - 1].to_s)
  end
end
Then /^I must see "([^"]*)" event before "([^"]*)" event$/ do |first_event, second_event|
  with_scope('#events') do
    all('.event')[0].all('a')[0].text.should == first_event
    all('.event')[1].all('a')[0].text.should == second_event
  end
end

Then /^I must see "([^"]*)" event at ([^"]*) the next week in the feed$/ do |event, hour|
  page.should have_content(event)
  page.should have_content(hour)
  page.should have_content(@event_date.day.to_s)
  page.should have_content(MONTHS[@event_date.month - 1].to_s)
end

Then /^I must see an ask for the feed option$/ do
  with_scope('#feeds') do
    all('.feed')[0].all('a')[0][:href].should =~ Regexp.new(Regexp.escape(path_to('the atom feed')))
  end
end
