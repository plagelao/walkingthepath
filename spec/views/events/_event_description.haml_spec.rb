require 'spec_helper'

describe "events/_event_description.haml" do

  let(:event) {stub_model(Event).as_null_object}

  it "needs the event title" do
    event.should_receive(:title)
    render 'events/event_description', :event => event
  end

  it "class change if long event title" do
    event.should_receive(:link)
    render 'events/event_description', :event => event
  end
end
