require 'spec_helper'

describe Announcer do

  let(:event_params) { {'title' => 'a coding dojo', 'link' => 'a link'} }
  let(:slot_params)  { {'datetime(1i)'=>'2011', 'datetime(2i)'=>'2', 'datetime(3i)'=>'15', 'datetime(4i)'=>'23', 'datetime(5i)'=>'56'} }
  let(:event) { stub(:event) }
  let(:slot) { stub(:slot) }
  let(:flash) { stub(:flash, :[]= => []) }
  let(:announcer) { Announcer.new(flash) }

  before do
    Event.stub(:new).and_return(event)
    event.stub(:build_slot).and_return(slot)
    event.stub(:save)
    event.stub(:valid?).and_return(true)
    event.stub(:errors).and_return({:title => [], :link => [], :date => []})
  end

  it "with the data filled by the user" do
    Event.should_receive(:new).with(event_params)
    announcer.announce_event(event_params, slot_params)
  end

  it "with a slot" do
    event.should_receive(:build_slot).with(slot_params)
    announcer.announce_event(event_params, slot_params)
  end

  it "by saving the new event" do
    event.should_receive(:save)
    announcer.announce_event(event_params, slot_params)
  end

  it 'invalid event data' do
    event.stub(:valid? => false)
    event.should_receive(:errors)
    announcer.announce_event(event_params, slot_params)
  end

end
