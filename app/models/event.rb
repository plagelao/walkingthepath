#encoding: utf-8
require 'date'

class Event < ActiveRecord::Base

  has_one :slot

  validates_presence_of :title, :message => "No seas vaguete y ponle un título al evento."
  validates_presence_of :link, :message => "Seguro que tienes un enlace a la descripción del evento por algún lado."
  validates_presence_of :slot, :message => "Seguro que sabes cuando se celebrará el evento."
  validates_associated :slot

  validate :event_link_must_be_a_url

  def self.for_today
    Slot.for_today.map(&:event)
  end

  def self.for_tomorrow
    Slot.for_tomorrow.map(&:event)
  end

  def self.in_the_future
    Slot.in_the_future.map(&:event)
  end

  delegate :month, :day, :time, :to => :slot

  def when
    "#{day} de #{month} a las #{time}"
  end

  def error_for(field)
    errors[field].first
  end

  private

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

end
