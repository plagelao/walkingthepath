require 'spec_helper'

describe EventsController do

  let(:event){ @mock_event = mock_model(Event).as_null_object }

  context "index of events" do
    before do
      Event.stub(:in_the_future) { [event] }
    end
    it "assigns all events as @events" do
      get :index
      assigns(:events).should eq([event])
    end
  end

  context "show an event" do
    before do
      Event.stub(:find) { event }
    end
    it "assigns the requested event as @event" do
      event.stub(:id).and_return(1234)
      event.should_receive(:link).and_return('http://www.google.es')
      get :show, :id => "1234"
    end
  end
end
