require 'spec_helper'

describe "events/new.haml" do
  before do
    assign(:event, stub_model(Event))
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
    rendered.should have_selector('form select#event_date_time_1i')
    rendered.should have_selector('form select#event_date_time_2i')
    rendered.should have_selector('form select#event_date_time_3i')
  end

  it "has an input field for the event time" do
    render
    rendered.should have_selector('form select#event_date_time_4i')
    rendered.should have_selector('form select#event_date_time_5i')
  end

  it "has a button to create the event" do
    render
    rendered.should have_selector('form input#new_event')
  end
end
