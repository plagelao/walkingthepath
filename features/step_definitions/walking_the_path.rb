# encoding: utf-8
MONTHS = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
Given /^"([^"]*)" event the (next|past) week at ([^"]*)$/ do |event, time, hour|
  @event_date = next_week
  @event_date = previous_week if time == 'past'
  event = Event.create(@event_date.year, month_name(@event_date.month), @event_date.day, hour, event, '#')
  event.save
end

Given /^"([^"]*)" event the next week at ([^"]*) linked to "([^"]*)"$/ do |event, hour, link|
  @event_date = next_week
  event = Event.create(@event_date.year, month_name(@event_date.month), @event_date.day, hour, event, link)
  event.save
end

When /^I ask for the next events$/ do
  visit path_to('the homepage')
end

When /^I subscribe to the events update$/ do
  visit path_to('the atom feed')
end

When /^I create "([^"]*)" event for the next week at ([^"]*)$/ do |event, hour|
  pending
  @event_date = next_week
  visit path_to('the homepage')
  with_scope('#new_event') do
    click_link('new event')
  end
  fill_in(:event_title, event)
  fill_in(:event_date, @event_date)
  fill_in(:event_link, '')
  click_button(:new_event)
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
    page.should have_content(month_name(@event_date.month).to_s)
  end
end
Then /^I must see "([^"]*)" event before "([^"]*)" event$/ do |first_event, second_event|
  with_scope('#events') do
    all('.event_with_one_line_title')[0].all('a')[0].text.should == first_event
    all('.event_with_one_line_title')[1].all('a')[0].text.should == second_event
  end
end

Then /^I must receive a notification of "([^"]*)" event at ([^"]*) the next week$/ do |event, hour|
  page.should have_content(event)
  page.should have_content(hour)
  page.should have_content(@event_date.day.to_s)
  page.should have_content(month_name(@event_date.month).to_s)
end

Then /^I must see an ask for the feed option$/ do
  with_scope('#feeds') do
    all('.feed')[0].all('a')[0][:href].should =~ Regexp.new(Regexp.escape(path_to('the atom feed')))
  end
end
