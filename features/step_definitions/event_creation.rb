#encoding: utf-8
When /^I create "([^"]*)" event for the next week at ([^"]*)$/ do |event, time|
  @event_date = next_week
  visit path_to('the homepage')
  within('#add_event') do
    click_link("Añadir un evento")
  end
  fill_in('event_title', :with => event)
  select(@event_date.year.to_s, :from =>'event_date_1i')
  select(month_number_in(@event_date).to_s, :from =>'event_date_2i')
  select(@event_date.day.to_s, :from =>'event_date_3i')
  select(time.split(':')[0], :from =>'event_date_4i')
  select(time.split(':')[1], :from =>'event_date_5i')
  fill_in('event_link', :with => '')
  click_button('Crear')
end

Then /^I am not able to create new events$/ do
  page.should_not have_content( "Añadir un evento")
end
