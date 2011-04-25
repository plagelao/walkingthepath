class WalkingOnTwitter
  def self.update
    Event.for_today.each do |event|
      Twitter.update("Hoy a las #{event.time}, #{event.title}. Más información en #{event.link} #{cheering_message}")
    end
  end

  def self.cheering_message
    messages = ['¡No puedes faltar!', '¿Te lo vas a perder?', '¡No te lo pierdas!', '¡No faltes!', '¡Va a ser la caña!']
    messages[rand(messages.size)]
  end
end
