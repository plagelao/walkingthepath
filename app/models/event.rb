class Event < ActiveRecord::Base
  MONTHS = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
  def self.create(year, month, day, hour, title, link)
    Event.new(:month => month, :day => day, :hour => hour, :title => title, :date => DateTime.civil(year, MONTHS.index(month) + 1, day, hour[0,2].to_i, hour[3,2].to_i).strftime('%Y%m%d%H%M'), :link => link)
  end
  def month
    MONTHS[date.to_s.slice(4..5).to_i - 1]
  end
  def day
    date.to_s.slice(6..7).to_i
  end
  def hour
    "#{date.to_s.slice(8..9)}:#{date.to_s.slice(10..11)}"
  end
  def when
    "#{day} de #{month} a las #{hour}"
  end
end
