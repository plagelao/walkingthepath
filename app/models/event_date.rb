class EventDate

  MONTHS = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
  DATE_TIME_FORMAT = '%Y%m%d%H%M'

  def self.now
    DateTime.now.strftime(DATE_TIME_FORMAT).to_i
  end

  def initialize(date)
    @date = date
  end

  def year
    @date.to_s.slice(0..3).to_i
  end

  def month
    MONTHS[@date.to_s.slice(4..5).to_i - 1]
  end

  def day
    @date.to_s.slice(6..7).to_i
  end

  def time
    return '---' if undetermined_hour?
    "#{hours}:#{minutes}"
  end

  def to_i
    @date
  end

  def to_date
    return DateTime.civil(year, @date.to_s.slice(4..5).to_i, day) if year != 0
    DateTime.now
  end
  private

  def undetermined_hour?
    @date.to_s.slice(8..11).to_i == 0
  end

  def hours
    @date.to_s.slice(8..9)
  end

  def minutes
    @date.to_s.slice(10..11)
  end

end

