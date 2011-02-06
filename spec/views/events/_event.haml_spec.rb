require 'spec_helper'

describe "events/_event.haml" do

  it "ask for the event id" do
    event = mock_model(Event).as_null_object
    event.should_receive(:id)
    render 'events/event', :event => event
  end

  it "ask for the event month" do
    event = mock_model(Event).as_null_object
    event.should_receive(:month)
    render 'events/event', :event => event
  end

  it "ask for the event day" do
    event = mock_model(Event).as_null_object
    event.should_receive(:day)
    render 'events/event', :event => event
  end

  it "ask for the event time" do
    event = mock_model(Event).as_null_object
    event.should_receive(:time)
    render 'events/event', :event => event
  end

end
