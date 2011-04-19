require 'spec_helper'

describe Slot do
  context 'when asked for the datetime' do
    let(:now) { DateTime.civil(2011, 1, 2, 3, 4) }
    let(:slot) { Slot.new(:datetime => now) }

    it 'knows the year' do
      slot.year.should be 2011
    end

    it 'knows the month' do
      slot.month.should == 'Enero'
    end

    it 'knows the day' do
      slot.day.should be 2
    end

    it 'knows the hour' do
      slot.hour.should be 3
    end

    it 'knows the minute' do
      slot.minute.should be 4
    end
  end
end
