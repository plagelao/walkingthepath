#encoding: utf-8
require 'spec_helper'

describe "events/_events.haml" do
  context "no events" do

    before do
      render 'events/events', :events => []
    end

    it "shows a message" do
      rendered.should contain("Ningún evento próximamente :(")
    end

    it "does not show any events" do
      rendered.should_not have_selector('.event')
    end

  end

  context "with events" do

    it "shows the events when there are some" do
      event = mock_model(Event).as_null_object
      event.stub(:id).and_return(0)
      render 'events/events', :events => [event]
      rendered.should have_selector('.event')
      rendered.should have_selector('#event_0')
    end

  end
end
