class Slot < ActiveRecord::Base

  belongs_to :event

  scope :for_today, where("datetime >= :today AND datetime < :tomorrow", :today => DateTime.now, :tomorrow => DateTime.tomorrow)
  scope :for_tomorrow, where("datetime >= :tomorrow AND datetime < :two_days_ahead", :tomorrow => DateTime.tomorrow, :two_days_ahead => DateTime.tomorrow + 1.day)
  scope :to_come, where("datetime > :today", :today => DateTime.now)
  scope :ordered_by_date, order('datetime ASC')

  validates_presence_of :datetime, :message => "Seguro que sabes cuando se celebrará el evento."
  validate :date_must_be_in_the_future

  def self.in_the_future
    Slot.to_come.ordered_by_date
  end

  MONTHS = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']

  def year
    datetime.year
  end

  def month
   Slot::MONTHS[datetime.month - 1]
  end

  def day
    datetime.day
  end

  def time
    return '---' if undefined_time
    "#{hours}:#{minutes}"
  end

  def error_for(field)
    errors[field].first
  end

  def datetime_as_string
    return '' unless datetime
    datetime.to_s(:walking)
  end

  def datetime_as_string=(value)
    write_datetime(value)
  rescue
  end

  private

  def write_datetime(value)
    write_attribute(:datetime, DateTime.strptime(value, "%d/%m/%Y %H:%M"))
  rescue
    write_datetime_with_undefined_time(value)
  end

  def write_datetime_with_undefined_time(value)
    write_attribute(:datetime, DateTime.strptime(value, "%d/%m/%Y"))
    write_attribute(:undefined_time, true)
  rescue
  end

  def hours
    "0#{datetime.hour}".slice(-2..-1)
  end

  def minutes
    "0#{datetime.min}".slice(-2..-1)
  end

  def date_must_be_in_the_future
    errors.add(:datetime, "La fecha del evento ya ha pasado, ¡Ojo!") if datetime and Time.now > datetime
  end
end
