class OldSlot

  DATE_TIME_FORMAT = '%Y%m%d%H%M'

  def self.now
    DateTime.now
  end

  def initialize(date)
    @date = date
  end

  def year
    @date.year
  end

  def month
   Slot::MONTHS[@date.month - 1]
  end

  def day
    @date.day
  end

  def time
    return '---' if undetermined_hour?
    "#{hours}:#{minutes}"
  end

  def to_i
    @date
  end

  def date_time
    @date
  end
  private

  def undetermined_hour?
    @date.hour == 0 && @date.min == 0
  end

  def hours
    "0#{@date.hour}".slice(-2..-1)
  end

  def minutes
    "0#{@date.min}".slice(-2..-1)
  end
end

