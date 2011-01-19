atom_feed do |feed|
  feed.title "Let's walh the path together! - Events"

  latest_order = @events
  #feed.updated( latest_order && latest_order.updated_at )

  @events.each do |event|
    feed.entry(event) do |entry|
      entry.title event.title
      entry.summary event.title
      entry.updated(event.updated_at.strftime("%Y-%m-dT%H:%M:%SZ"))
      entry.author 'plagelao'
    end
  end
end

