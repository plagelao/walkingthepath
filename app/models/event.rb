class Event < ActiveRecord::Base
  MONTHS = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
  def self.create(year, month, day, hour, title, link)
    Event.new(:month => month, :day => day, :hour => hour, :title => title, :date => DateTime.civil(year, MONTHS.index(month) + 1, day, hour[0,2].to_i, hour[3,2].to_i).strftime('%Y%m%d%H%M'), :link => link)
  end
  def when
    DateTime.civil(2011, MONTHS.index(month) + 1, day, hour[0,2].to_i, hour[3,2].to_i).strftime("%Y-%m-dT%H:%M:%SZ")
  end
  def when_for_humans
    "#{day} de #{month} a las #{hour}"
  end
end
