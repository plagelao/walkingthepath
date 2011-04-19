require 'spec_helper'

describe OldSlot do

  context 'when asked for the datetime' do
    let(:now) { stub(:now, :year => 2011,
                           :month => 1,
                           :day => 2,
                           :hour =>3,
                           :min => 4) }
    let(:slot) { OldSlot.new(now).date_time }

    it 'knows the year' do
      slot.year.should be 2011
    end

    it 'knows the month' do
      slot.month.should be 1
    end

    it 'knows the day' do
      slot.day.should be 2
    end

    it 'knows the day' do
      slot.hour.should be 3
    end

    it 'knows the minute' do
      slot.min.should be 4
    end
  end
end
