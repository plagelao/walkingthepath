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

  context "adding new events" do

    context "if authenticated" do
      before do
        session[:user_id] = '1234'
      end

      it "prepares the new event creation when asked" do
        get :new
        assigns(:event).should_not be_nil
      end
    end

    context "if not authenticated" do
      it "is not possible" do
        get :new
        response.should redirect_to(events_path)
      end
    end
  end

  context "creating new events" do

    let(:params) { {:event => {'title' => 'a coding dojo', 'link' => 'a link', "date(1i)"=>"2011", "date(2i)"=>"2", "date(3i)"=>"15", "date(4i)"=>"23", "date(5i)"=>"56"}} }

    context "if authenticated" do

      before do
        session[:user_id] = '1234'
      end

      it "can create new events" do
        transformed_event_data = {:title => 'a coding dojo', :link => 'a link', :date=>201102152356}
        Event.should_receive(:new).with(transformed_event_data).and_return(event)
        event.should_receive(:save)
        get :create, params
        response.should redirect_to(events_path)
      end
    end

    context "if not authenticated" do
      it "is not possible" do
        Event.should_not_receive(:new)
        get :create, params
        response.should redirect_to(events_path)
      end
    end

  end
end
