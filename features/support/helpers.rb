#encoding: utf-8
def next_week_with_undefined_time
  @undefined_time = true
  today_plus(7, '00:00')
end

def next_week(time)
  today_plus(7, time)
end

def previous_week(time)
  today_plus(-7, time)
end

def today_plus(days, time)
  date = DateTime.now + days
  @datetime = DateTime.civil(date.year, date.month, date.day, time[0,2].to_i, time[3,2].to_i)
end

def create_event event
  visit_create_an_event
  set_title_as event[:title] if event.has_key?(:title)
  set_link_as event[:link] if event.has_key?(:link)
  set_datetime_as event[:datetime]
  click_button('Crear Evento')
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

def set_datetime_as datetime
  if @undefined_time
    fill_in('slot_datetime_as_string', :with => datetime.to_s(:without_time))
  else
    fill_in('slot_datetime_as_string', :with => datetime.to_s(:walking))
  end
  @datetime = datetime
end

def event_title
  find_field('event_title').value
end

def event_link
  find_field('event_link').value
end

def event_datetime
  datetime = find_field('slot_datetime_as_string').value
  DateTime.strptime(datetime, "%d/%m/%Y %H:%M")
end
