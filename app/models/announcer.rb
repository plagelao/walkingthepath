class Announcer

  attr_reader :flash

  def initialize(flash)
    @flash = flash
  end

  def announce_event(event, slot)
    event = Event.new event
    event.build_slot slot
    event.save
    return false if event.valid?
    log_errors(event)
  end

  private

  def log_errors(event)
    flash[:notice] = []
    flash[:notice] << event.errors[:title].first unless event.errors[:title].empty?
    flash[:notice] << event.errors[:link].first unless event.errors[:link].empty?
    flash[:notice] << event.errors[:date].first unless event.errors[:date].empty?
    event
  end
end