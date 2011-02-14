require 'spec_helper'

describe "events/_event_date.haml" do
  let(:event) { mock_model(Event).as_null_object }

  it "ask for the event month" do
    event.should_receive(:month)
    render 'events/event', :event => event
  end

  it "ask for the event day" do
    event.should_receive(:day)
    render 'events/event', :event => event
  end

  it "ask for the event time" do
    event.should_receive(:time)
    render 'events/event', :event => event
  end

end
