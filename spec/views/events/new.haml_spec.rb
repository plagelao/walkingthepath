require 'spec_helper'

describe "events/new.haml" do
  before do
    assign(:event, stub_model(Event, :slot => stub_model(Slot)))
  end
  it "has an input field for the event title" do
    render
    rendered.should have_selector('form input#event_title')
  end

  it "has an input field for the event link" do
    render
    rendered.should have_selector('form input#event_link')
  end

  it "has an input field for the event date and time" do
    render
    rendered.should have_selector('form input#slot_datetime_as_string')
  end

  it "has a button to create the event" do
    render
    rendered.should have_selector('form input#event_submit')
  end
end
