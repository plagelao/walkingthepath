require 'spec_helper'

describe Slot do
  shared_examples_for 'a slot with a valid date' do
    it 'knows the year' do
      slot.year.should be 2011
    end

    it 'knows the month' do
      slot.month.should == 'Enero'
    end

    it 'knows the day' do
      slot.day.should be 2
    end
  end

  shared_examples_for 'a slot with a valid time' do
    it 'knows the time' do
      slot.time.should == '03:04'
    end
  end

  context 'when asked for the datetime' do
    let(:now) { DateTime.civil(2011, 1, 2, 3, 4) }
    let(:slot) { Slot.new(:datetime => now) }

    it_should_behave_like 'a slot with a valid date'
    it_should_behave_like 'a slot with a valid time'

    it 'date as string returns the right format' do
      slot.datetime_as_string.should == '02/01/2011 03:04'
    end
  end

  context 'when created with a date as string' do
    let(:now) { '02/01/2011 03:04' }
    let(:slot) { Slot.new(:datetime_as_string => now) }

    it_should_behave_like 'a slot with a valid date'
    it_should_behave_like 'a slot with a valid time'

    context 'that is not a valid date' do
      let(:now) { 'not a date' }
      it 'sets a nil datetime' do
        slot.datetime.should == nil
      end
      it 'date time as string returns an empty string' do
        slot.datetime_as_string.should == ''
      end
    end

    context 'with an undefined time' do
      let(:now) { '02/01/2011' }

      it_should_behave_like 'a slot with a valid date'

      it 'does not know the time' do
        slot.time.should == '---'
      end

      it 'date as string returns the right format' do
        slot.datetime_as_string.should == '02/01/2011'
      end
    end
  end

  context 'validates' do
    let(:slot) { Slot.new }
    it "that has a date" do
      slot.should_not be_valid
      slot.error_for(:datetime).should == "Seguro que sabes cuando se celebrará el evento."
    end

    let(:yesterday) { DateTime.civil(2011, 1, 2, 3, 4) }
    it "that has a date in the future" do
      slot.datetime = yesterday
      slot.should_not be_valid
      slot.error_for(:datetime).should == "La fecha del evento ya ha pasado, ¡Ojo!"
    end
  end
end
