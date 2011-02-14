require 'spec_helper'

describe "events/_event.haml" do
  let(:event) { mock_model(Event).as_null_object }

  it "ask for the event id" do
    event.should_receive(:id)
    render 'events/event', :event => event
  end

  it "renders the _date template" do
    stub_template('events/_event_date.haml' => 'rendering an event date')
    render 'events/event', :event => event
    rendered.should contain('rendering an event date')
  end

  it "renders the _description template" do
    stub_template('events/_event_description.haml' => 'rendering an event description')
    render 'events/event', :event => event
    rendered.should contain('rendering an event description')
  end
end
