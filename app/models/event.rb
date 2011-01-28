class Event < ActiveRecord::Base
  MONTHS = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
  DATE_TIME_FORMAT = '%Y%m%d%H%M'
  def self.create(year, month, day, time, title, link)
    Event.new(:title => title, :date => date_time(year, month, day, time), :link => link)
  end
  def self.date_time(year, month, day, time)
    DateTime.civil(year, MONTHS.index(month) + 1, day, time[0,2].to_i, time[3,2].to_i).strftime(DATE_TIME_FORMAT)
  end
  def self.now
    DateTime.now.strftime(DATE_TIME_FORMAT)
  end
  def month
    MONTHS[date.to_s.slice(4..5).to_i - 1]
  end
  def day
    date.to_s.slice(6..7).to_i
  end
  def time
    return '---' if undetermined_hour?
    "#{hours}:#{minutes}"
  end
  def undetermined_hour?
    date.to_s.slice(8..11).to_i == 0
  end
  def hours
    date.to_s.slice(8..9)
  end
  def minutes
    date.to_s.slice(10..11)
  end
  def when
    "#{day} de #{month} a las #{time}"
  end
end
