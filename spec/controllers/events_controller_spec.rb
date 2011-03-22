#encoding: utf-8
require 'spec_helper'

describe EventsController do

  let(:event) { mock_model(Event, :id => 1234, :link =>'http://www.google.es', :save => true) }

  context "lists the events" do

    let(:events) {[event]}

    before do
      Event.stub(:in_the_future) { events }
    end

    it "that are in the future" do
      Event.should_receive(:in_the_future).and_return(events)
      get :index
    end

    it "passing them to the view" do
      get :index
      assigns(:events).should eq(events)
    end
  end

  context "shows an event" do

    before do
      Event.stub(:find => event)
    end

    it "that already exists in the system" do
      Event.should_receive(:find).with(1234).and_return(event)
      get :show, :id => 1234
    end

    it "redirecting to its link" do
      get :show, :id => 1234
      response.should redirect_to('http://www.google.es')
    end
  end


  context "if the user is authenticated" do

    before do
      session[:user_id] = 1234
    end

    context "prepares the creation of new events" do

      it "by setting the fields of the event as empty" do
        get :new
        assigns(:event).should_not be_nil
      end

    end

    context "creates new events" do

      let(:params) { {:event => {'title' => 'a coding dojo', 'link' => 'a link', 'date_time(1i)'=>'2011', 'date_time(2i)'=>'2', 'date_time(3i)'=>'15', 'date_time(4i)'=>'23', 'date_time(5i)'=>'56'}} }

      before do
        Event.stub(:new).and_return(event)
      end

      it "with the data filled by the user" do
        event_data = {:title => 'a coding dojo', :link => 'a link', :date=>201102152356}
        Event.should_receive(:new).with(event_data).and_return(event)
        get :create, params
      end

      it "by saving the new event" do
        event.should_receive(:save)
        get :create, params
      end

      it "and redirect to the list of events" do
        get :create, params
        response.should redirect_to(events_path)
      end

      context "but when the event does not have valid fields" do

        before do
          event.stub(:save).and_return(false)
          event.stub(:errors).and_return({:title => ['title error'],
                                          :link => ['link error']})
        end

        it "stays in the create form" do
          get :create, params
          response.should render_template(:new)
        end

        it "shows an error" do
          get :create, params
          flash.should contain("title error")
          flash.should contain("link error")
        end
      end

    end
  end

  context "if the user is not authenticated" do

    let(:params) { {:event => {'title' => 'a coding dojo', 'link' => 'a link', 'date(1i)'=>'2011', 'date(2i)'=>'2', 'date(3i)'=>'15', 'date(4i)'=>'23', 'date(5i)'=>'56'}} }

    it "does not allow the creation of new events" do
      get :new
      response.should redirect_to(events_path)
    end

    it "does not create the event" do
      Event.should_not_receive(:new)
      get :create, params
    end

    it "redirects to event list" do
      get :create, params
      response.should redirect_to(events_path)
    end
  end

end
