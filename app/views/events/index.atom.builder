atom_feed do |feed|
  feed.title "Let's walh the path together! - Events"

  latest_event = @events.sort_by(&:updated_at).last
  feed.updated( latest_event && latest_event.updated_at )

  @events.each do |event|
    feed.entry(event) do |entry|
      entry.title(event.title)
      entry.summary(event.when)
      entry.author do |author|
        entry.name 'plagelao'
      end
    end
  end
end

