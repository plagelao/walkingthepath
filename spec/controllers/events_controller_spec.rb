#encoding: utf-8
require 'spec_helper'

describe EventsController do

  let(:event) { mock_model(Event, :id => 1234, :link =>'http://www.google.es', :save => true) }
  let(:slot) { mock_model(Slot, :id => 1234) }

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

      let(:slot) { mock(:slot) }
      let(:event) { mock(:event, :build_slot => slot,
                                 :save => true) }
      let(:params) { {:event => {}, :slot => {}} }

      before do
        Event.stub(:new => event)
      end

      it 'with the data from params' do
        Event.should_receive(:new) .with(params[:event])
        get :create, params
      end

      it 'adds a slot from the params' do
        event.should_receive(:build_slot) .with(params[:slot])
        get :create, params
      end

      it "and redirect to the list of events" do
        get :create, params
        response.should redirect_to(events_path)
      end

      it "saves the event" do
        event.should_receive(:save)
        get :create, params
      end

      context "but when the event does not have valid fields" do

        before do
          event.stub(:save => false,
                     :errors => {:title => [], :link => []})
          slot.stub(:valid? => false,
                     :errors => {:datetime => []})
        end

        it "stays in the create form" do
          get :create, params
          response.should render_template(:new)
        end

        it 'assigns the invalid event' do
          get :create, params
          assigns[:event].should eq(event)
        end

      end

    end
  end

  context "if the user is not authenticated" do

    let(:params) { {:event => {'title' => 'a coding dojo', 'link' => 'a link', 'datetime'=>'15/02/2011 23:56'}} }

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
