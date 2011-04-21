#encoding: utf-8
def next_week(time = "19:30")
  today_plus(7, time)
end

def previous_week(time = "19:30")
  today_plus(-7, time)
end

def today_plus(days, time)
  date = DateTime.now + days
  DateTime.civil(date.year, date.month, date.day, time[0,2].to_i, time[3,2].to_i)
end

def month_number_in(date)
  date.month
end

def create_event event
  visit_create_an_event
  set_title_as event[:title] if event.has_key?(:title)
  set_link_as event[:link] if event.has_key?(:link)
  set_date_as event[:date]
  set_time_as event[:time] if event.has_key?(:time)
  set_undefined_time if event[:undefined_time]
  click_button('Crear')
end

def visit_create_an_event
  visit path_to('the homepage')
  within('#add_event') do
    click_link("Añadir un evento")
  end
end

def set_title_as title
  @title = title
  fill_in('event_title', :with => @title)
end

def set_link_as link
  @link = link
  fill_in('event_link', :with => @link)
end

def set_date_as date
  @date = date
  select(@date.year.to_s, :from =>'slot_datetime_1i')
  select(month_number_in(@date).to_s, :from =>'slot_datetime_2i')
  select(@date.day.to_s, :from =>'slot_datetime_3i')
end

def set_time_as time
  @time = time
  select(time.split(':')[0], :from =>'slot_datetime_4i')
  select(time.split(':')[1], :from =>'slot_datetime_5i')
end

def set_undefined_time
  check('slot_undefined_time')
end

def event_title
  find_field('event_title').value
end

def event_link
  find_field('event_link').value
end

def event_date
  page.should have_select('slot_datetime_1i', :options =>[@date.year.to_s])
  page.should have_select('slot_datetime_2i', :options =>[month_number_in(@date).to_s])
  page.should have_select('slot_datetime_3i', :options =>[@date.day.to_s])
  @date
end

def event_time
  page.should have_select('slot_datetime_4i', :options =>[@time.split(':')[0]])
  page.should have_select('slot_datetime_5i', :options =>[@time.split(':')[1]])
  @time
end

