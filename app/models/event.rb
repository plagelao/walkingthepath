#encoding: utf-8
class Event < ActiveRecord::Base

  validate :event_title_cannot_be_blank,
           :event_link_must_be_a_url

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

  def event_title_cannot_be_blank
    errors.add(:title, "No seas vaguete y ponle un título al evento.") if title.blank?
  end

  def event_link_must_be_a_url
    errors.add(:link, "Seguro que tienes un enlace a la descripción del evento por algún lado.") if link.blank?
    errors.add(:link, "Creo que el enlace que has escrito no es correcto. ¡Casi lo tienes!") if not link.blank? and invalid link
  end

  def invalid url
    begin
      return true if URI.parse(url).class != URI::HTTP
    rescue URI::InvalidURIError
      return true
    end
    false
  end
end
