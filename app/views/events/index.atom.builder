atom_feed do |feed|
  feed.title "Let's walh the path together! - Events"

  feed.updated(@events.last.updated_at)

  @events.each do |event|
    feed.entry(event) do |entry|
      entry.title(event.title)
      entry.summary(event.when_for_humans)
      entry.updated(event.when)
      entry.author 'plagelao'
    end
  end
end

