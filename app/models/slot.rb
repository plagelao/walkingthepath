class Slot < ActiveRecord::Base

  belongs_to :event

  scope :for_today, where("datetime >= :today AND datetime < :tomorrow", :today => DateTime.now, :tomorrow => DateTime.tomorrow)
  scope :for_tomorrow, where("datetime >= :tomorrow AND datetime < :two_days_ahead", :tomorrow => DateTime.tomorrow, :two_days_ahead => DateTime.tomorrow + 1)
  scope :to_come, where("datetime > :today", :today => DateTime.now)
  scope :ordered_by_date, order('datetime ASC')

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

  def hour
    datetime.hour
  end

  def minute
    datetime.min
  end

  def time
    return '---' if undefined_time
    "#{hours}:#{minutes}"
  end

  private

  def hours
    "0#{datetime.hour}".slice(-2..-1)
  end

  def minutes
    "0#{datetime.min}".slice(-2..-1)
  end
end
