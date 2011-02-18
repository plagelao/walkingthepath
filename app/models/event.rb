class Event < ActiveRecord::Base

  def self.in_the_future
    Event.to_come.ordered_by_date
  end

  scope :to_come, where("date > :today", :today => EventDate.now)
  scope :ordered_by_date, order('date ASC')

  def month
    datetime.month
  end

  def day
    datetime.day
  end

  def time
    datetime.time
  end

  def when
    "#{day} de #{month} a las #{time}"
  end

  private

  def datetime
    EventDate.new(date)
  end

end
