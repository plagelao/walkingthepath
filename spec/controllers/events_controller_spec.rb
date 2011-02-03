require 'spec_helper'

describe EventsController do

  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs).as_null_object
  end

  context "index of events" do
    it "assigns all events as @events" do
      Event.stub(:in_the_future) { [mock_event] }
      get :index
      assigns(:events).should eq([mock_event])
    end
  end

  context "show an event" do
    it "assigns the requested event as @event" do
      Event.stub(:find) { mock_event(:id => 37) }
      mock_event.should_receive(:link).and_return('http://www.google.es')
      get :show, :id => "37"
    end
  end

end
