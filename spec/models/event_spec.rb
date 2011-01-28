require 'spec_helper'

describe Event do
  let(:event){Event.create(2011,'Enero',12,'10:00','title','link')}
  it "a new event is created for a specific date" do
    event.date.should == 201101121000
  end

  it "updates the month when the date is changed" do
    event.date = 201102121000
    event.month.should == 'Febrero'
  end

  it "updates the day when the date is changed" do
    event.date = 201101131000
    event.day.should == 13
  end

  it "updates the hour when the date is changed" do
    event.date = 201101121100
    event.time.should == '11:00'
  end

  it "shows an indefined hour when hour is set to 0000" do
    event.date = 201101120000
    event.time.should == '---'
  end

end
