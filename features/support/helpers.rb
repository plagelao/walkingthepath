#encoding: utf-8
def next_week(time = "19:30")
  today_plus(7, time)
end

def previous_week(time = "19:30")
  today_plus(-7, time)
end

def today_plus(days, time)
  date = DateTime.now + days
  EventDate.new(DateTime.civil(date.year, date.month, date.day, time[0,2].to_i, time[3,2].to_i).strftime(EventDate::DATE_TIME_FORMAT))
end

def month_number_in(date)
  EventDate::MONTHS.index(date.month) +1
end

def visit_create_an_event
  visit path_to('the homepage')
  within('#add_event') do
    click_link("Añadir un evento")
  end
end

def set_next_week_as_event_date
  @event_date = next_week
  select(@event_date.year.to_s, :from =>'event_date_1i')
  select(month_number_in(@event_date).to_s, :from =>'event_date_2i')
  select(@event_date.day.to_s, :from =>'event_date_3i')
end

def set_event_time_as time
  select(time.split(':')[0], :from =>'event_date_4i')
  select(time.split(':')[1], :from =>'event_date_5i')
end
