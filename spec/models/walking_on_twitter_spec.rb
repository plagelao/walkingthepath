require 'spec_helper'

describe WalkingOnTwitter do
  context 'sends a tweet when updating' do

    let(:event) {stub(:event, :title => "An event",
                              :link => "A link",
                              :time => "A time")}
    let(:events) {[event]}

    before do
      Twitter.stub(:update)
      Googl.stub(:shorten => 'A link')
      Event.stub(:for_today).and_return(events)
      Event.stub(:for_tomorrow).and_return([])
      WalkingOnTwitter.stub(:cheering_message).and_return('¿Te lo vas a perder?')
    end

    it 'gets the events for today' do
      Event.should_receive(:for_today).and_return([])
      WalkingOnTwitter.update
    end

    it 'gets the events for tomorrow' do
      Event.should_receive(:for_tomorrow).and_return([])
      WalkingOnTwitter.update
    end

    it 'asks for the title of the event' do
      event.should_receive(:title)
      WalkingOnTwitter.update
    end

    it 'asks for the link of the event' do
      event.should_receive(:link)
      WalkingOnTwitter.update
    end

    it 'asks for the time of the event' do
      event.should_receive(:time)
      WalkingOnTwitter.update
    end

    it 'sends a twitter update for the event' do
      Twitter.should_receive(:update).with("Hoy a las A time, An event. Más información en A link ¿Te lo vas a perder?")
      WalkingOnTwitter.update
    end

    context 'when there are events for today' do

      let(:events) {[event, event]}

      it 'sends a twitter update for each event' do
        Twitter.should_receive(:update).twice
        WalkingOnTwitter.update
      end

    end

    context 'when there are not events for today' do

      let(:events) {[]}

      it 'does not update twitter' do
        Twitter.should_not_receive(:update)
        WalkingOnTwitter.update
      end

    end
  end
end
