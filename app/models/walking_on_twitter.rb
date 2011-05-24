#encode: utf-8
class WalkingOnTwitter
  def self.update
    self.tweet_today_events
    self.tweet_tomorrow_events
  end

  def self.tweet_today_events
    Event.for_today.each do |event|
      Twitter.update(message_for_today(event))
    end
  end

  def self.tweet_tomorrow_events
    Event.for_tomorrow.each do |event|
      Twitter.update(message_for_tomorrow(event))
    end
  end

  def self.message_for_today(event)
    self.message_for('Hoy', event)
  end

  def self.message_for_tomorrow(event)
    self.message_for('Mañana', event)
  end

  def self.message_for(day, event)
    message = "#{day} a las #{event.time}, #{event.title}. Más información en #{short(event.link)} #{cheering_message}"
    return message if message.size <= 140
    message = "#{day} a las #{event.time}, #{event.title}. #{cheering_message}" if message.size <= 140
    "#{day} #{event.title}"
  end

  def self.cheering_message
    messages = ['¡No puedes faltar!', '¿Te lo vas a perder?', '¡No te lo pierdas!', '¡No faltes!', '¡Va a ser la caña!']
    messages[rand(messages.size)]
  end

  def self.short(url)
    Googl.shorten(url).short_url
  end
end
