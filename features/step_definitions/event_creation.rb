#encoding: utf-8
When /^I create "([^"]*)" event for the next week at ([^"]*)$/ do |title, time|
  create_event(:title => title,
               :link => 'http://Alink.es',
               :date => next_week,
               :time => time)
end

When /^I create an event without title$/ do
  create_event(:link => 'http://Alink.es',
               :date => next_week,
               :time => '10:30')
end

When /^I create an event without link$/ do
  create_event(:title => 'A title',
               :date => next_week,
               :time => '10:30')
end

When /^I create an event with a date in the past$/ do
  create_event(:title => 'A title',
               :link => 'http://Alink.es',
               :date => previous_week,
               :time => '10:30')
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
  event_title.should == @title if @title
  event_link.should == @link if @link
  event_date.should == @date if @date
  event_time.should == @time if @time
end
