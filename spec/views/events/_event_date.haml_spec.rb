require 'spec_helper'

describe "events/_event_date.haml" do

  it "ask for the event month" do
    render 'events/event_date', :month => 'Enero', :day => 2, :time => '20:00'
    rendered.should have_selector('.month')
  end

  it "ask for the event day" do
    render 'events/event_date', :month => 'Enero', :day => 2, :time => '20:00'
    rendered.should have_selector('.day')
  end

  it "ask for the event time" do
    render 'events/event_date', :month => 'Enero', :day => 2, :time => '20:00'
    rendered.should have_selector('.time')
  end
end
