#encoding: utf-8
require 'date'

class Event < ActiveRecord::Base

  validates_presence_of :title, :message => "No seas vaguete y ponle un título al evento."
  validates_presence_of :link, :message => "Seguro que tienes un enlace a la descripción del evento por algún lado."
  validate :event_link_must_be_a_url,
           :event_date_must_be_in_the_future

  def self.in_the_future
    Event.to_come.ordered_by_date
  end

  scope :to_come, where("datetime > :today", :today => EventDate.now)
  scope :ordered_by_date, order('datetime ASC')

  delegate :month, :day, :time, :date_time, :to => :date_time

  def when
    "#{day} de #{month} a las #{time}"
  end

  private

  def date_time
    EventDate.new(datetime)
  end

  def event_link_must_be_a_url
    errors.add(:link, "Creo que el enlace que has escrito no es correcto. ¡Casi lo tienes!") if not link.blank? and invalid link
  end

  def invalid url
    begin
      uri_class = URI.parse(url).class
      return true if uri_class != URI::HTTP and uri_class != URI::HTTPS
    rescue URI::InvalidURIError
      return true
    end
    false
  end

  def event_date_must_be_in_the_future
    errors.add(:date, "La fecha del evento ya ha pasado, ¡Ojo!") if DateTime.now > datetime
  end
end
