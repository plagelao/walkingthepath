#encoding: utf-8
require 'spec_helper'

describe "events/_events.haml" do
  context "no events" do
    let(:events) { [] }

    it "shows a message" do
      render 'events/events', :events => []
      rendered.should contain("Ningún evento próximamente :(")
    end

    it "does not show any events" do
      view.should_not_receive(:render).with('event')
      view.render 'events/events', :events => []
    end

  end

  context "with events" do
    let(:events) { [mock_model(Event)] }

    it "shows the events when there are some" do
      stub_template('events/_event.haml' => 'rendering an event')
      render 'events/events', :events => events
      rendered.should contain('rendering an event')
    end

  end
end
