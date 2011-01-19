atom_feed do |feed|
  feed.title "Let's walh the path together! - Events"

  latest_order = @events
  #feed.updated( latest_order && latest_order.updated_at )

  @events.each do |event|
    feed.entry(event) do |entry|
      entry.title(event.title)
      entry.summary(event.when_for_humans)
      entry.updated(event.when)
      entry.author 'plagelao'
    end
  end
end

