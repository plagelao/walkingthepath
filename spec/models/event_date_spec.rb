require 'spec_helper'

describe EventDate do

  context 'when asked for the datetime' do
    let(:now) { stub(:now, :year => 2011,
                           :month => 1,
                           :day => 2,
                           :hour =>3,
                           :min => 4) }
    let(:date) { EventDate.new(now).date_time }

    it 'knows the year' do
      date.year.should be 2011
    end

    it 'knows the month' do
      date.month.should be 1
    end

    it 'knows the day' do
      date.day.should be 2
    end

    it 'knows the day' do
      date.hour.should be 3
    end

    it 'knows the minute' do
      date.min.should be 4
    end
  end
end
