# encoding: utf-8
Given /^"([^"]*)" event the (next|past) week at ([^"]*) linked to "([^"]*)"$/ do |title, time, hour, link|
  next_week(hour)
  previous_week(hour) if time == 'past'
  event = Event.new
  event.build_slot :datetime => @datetime
  event.title = title
  event.link = link
  event.save
end

Given /^"([^"]*)" event (today|tomorrow) at ([^"]*)$/ do |title, day, time|
  event = Event.new
  days = day == 'today'? 0 : 1
  event.build_slot :datetime => today_plus(days, time)
  event.title = title
  event.link = 'http://Alink.es'
  event.save
end

Given /^"([^"]*)" event the (next|past) week at ([^"]*)$/ do |title, time, hour|
  Given %{"#{title}" event the #{time} week at #{hour} linked to "http://Alink.es"}
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
    page.should have_content(@datetime.day.to_s)
    page.should have_content(Slot::MONTHS[@datetime.month - 1])
  end
end

Then /^I must see "([^"]*)" event with an undefined time$/ do |event|
  within('#events') do
    page.should have_content(event)
    page.should have_content('---')
    page.should have_content(@datetime.day.to_s)
    page.should have_content(Slot::MONTHS[@datetime.month - 1])
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
  page.should have_content(@datetime.day.to_s)
  page.should have_content(Slot::MONTHS[@datetime.month - 1])
end

Then /^I must see an ask for the feed option$/ do
  within('#feeds') do
    all('.feed')[0].all('a')[0][:href].should =~ Regexp.new(Regexp.escape(path_to('the atom feed')))
  end
end
