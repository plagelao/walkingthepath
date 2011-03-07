#encoding: utf-8
When /^I create "([^"]*)" event for the next week at ([^"]*)$/ do |event, time|
  visit_create_an_event
  fill_in('event_title', :with => event)
  set_next_week_as_event_date
  set_event_time_as time
  fill_in('event_link', :with => 'http://Alink.es')
  click_button('Crear')
end

When /^I create an event without title$/ do
  visit_create_an_event
  set_next_week_as_event_date
  set_event_time_as '10:30'
  fill_in('event_link', :with => 'http://Alink.es')
  click_button('Crear')
end

When /^I create an event without link$/ do
  visit_create_an_event
  fill_in('event_title', :with => 'A title')
  set_next_week_as_event_date
  set_event_time_as '10:30'
  click_button('Crear')
end

Then /^I am not able to create new events$/ do
  page.should_not have_content("Añadir un evento")
end

Then /^I get notified about the need to fill the event title$/ do
  page.should have_content("No seas vaguete y ponle un título al evento.")
end

Then /^I get notified about the need to fill the event link$/ do
  page.should have_content("Seguro que tienes un enlace a la descripción del evento por algún lado.")
end
