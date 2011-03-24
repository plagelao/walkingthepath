#encoding: utf-8
When /^I create "([^"]*)" event for the next week at ([^"]*)$/ do |event, time|
  visit_create_an_event
  @event = event
  fill_in('event_title', :with => event)
  set_next_week_as_event_date
  set_event_time_as time
  @link = 'http://Alink.es'
  fill_in('event_link', :with => @link)
  click_button('Crear')
end

When /^I create an event without title$/ do
  visit_create_an_event
  set_next_week_as_event_date
  set_event_time_as '10:30'
  @link = 'http://Alink.es'
  fill_in('event_link', :with => @link)
  click_button('Crear')
end

When /^I create an event without link$/ do
  visit_create_an_event
  @title = 'A title'
  fill_in('event_title', :with => @title)
  set_next_week_as_event_date
  set_event_time_as '10:30'
  click_button('Crear')
end

When /^I create an event with a date in the past$/ do
  visit_create_an_event
  @title = 'A title'
  fill_in('event_title', :with => @title)
  @link = 'http://Alink.es'
  fill_in('event_link', :with => @link)
  set_previous_week_as_event_date
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

Then /^I get notified about the need to set only future dates$/ do
  page.should have_content("La fecha del evento ya ha pasado, ¡ojo!")
end

Then /^the fields stay filled with the old data$/ do
  find_field('event_title').value.should == @title if @title
  find_field('event_link').value.should == @link if @link
  page.should have_select('event_date_time_1i', :options =>[@date.year.to_s]) if @date
  page.should have_select('event_date_time_2i', :options =>[month_number_in(@date).to_s]) if @date
  page.should have_select('event_date_time_3i', :options =>[@date.day.to_s]) if @date
  page.should have_select('event_date_time_4i', :options =>[@time.split(':')[0]]) if @time
  page.should have_select('event_date_time_5i', :options =>[@time.split(':')[1]]) if @time
end
