require 'spec_helper'

describe "events/_event_date.haml" do

  it "ask for the event month" do
    event = mock_model(Event).as_null_object
    event.should_receive(:month)
    render 'events/event_date', :event => event
  end

  it "ask for the event day" do
    event = mock_model(Event).as_null_object
    event.should_receive(:day)
    render 'events/event_date', :event => event
  end

  it "ask for the event time" do
    event = mock_model(Event).as_null_object
    event.should_receive(:time)
    render 'events/event_date', :event => event
  end
end
