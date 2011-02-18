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
