class WalkingOnTwitter
  def self.update
    Event.for_today.each do |event|
      Twitter.update(message_for(event))
    end
  end

  def self.message_for(event)
    message = "Hoy a las #{event.time}, #{event.title}. Más información en #{event.link} #{cheering_message}"
    return message if message.size <= 140
    message = "Hoy a las #{event.time}, #{event.title}. #{cheering_message}" if message.size <= 140
    "Hoy #{event.title}"
  end

  def self.cheering_message
    messages = ['¡No puedes faltar!', '¿Te lo vas a perder?', '¡No te lo pierdas!', '¡No faltes!', '¡Va a ser la caña!']
    messages[rand(messages.size)]
  end
end
