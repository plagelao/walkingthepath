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

def fill_date
  select(@date.year.to_s, :from =>'event_date_time_1i')
  select(month_number_in(@date).to_s, :from =>'event_date_time_2i')
  select(@date.day.to_s, :from =>'event_date_time_3i')
end

def set_next_week_as_event_date
  @date = next_week
  fill_date
end

def set_previous_week_as_event_date
  @date = previous_week
  fill_date
end

def set_event_time_as time
  @time = time
  select(time.split(':')[0], :from =>'event_date_time_4i')
  select(time.split(':')[1], :from =>'event_date_time_5i')
end
