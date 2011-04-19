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

  it "has an input field for the event date" do
    render
    rendered.should have_selector('form select#slot_datetime_1i')
    rendered.should have_selector('form select#slot_datetime_2i')
    rendered.should have_selector('form select#slot_datetime_3i')
  end

  it "has an input field for the event time" do
    render
    rendered.should have_selector('form select#slot_datetime_4i')
    rendered.should have_selector('form select#slot_datetime_5i')
  end

  it "has a button to create the event" do
    render
    rendered.should have_selector('form input#new_event')
  end
end
