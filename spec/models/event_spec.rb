#encoding: utf-8
require 'spec_helper'

describe Event do

  let(:tomorrow) { DateTime.now + 1 }
  let(:event) {Event.new({:slot => Slot.new(:datetime => tomorrow), :title => 'title', :link => 'http://www.link.es'})}

  it "is created for a specific date" do
    event.slot.datetime.should == tomorrow
  end

  context "validates" do

    it "that has a title" do
      event.title = nil
      expect{event.save!}.to raise_error(/No seas vaguete y ponle un título al evento/)
    end

    it "that has a link" do
      event.link = nil
      expect{event.save!}.to raise_error(/Seguro que tienes un enlace a la descripción del evento por algún lado./)
    end

    it "that has a valid link" do
      event.link = 'not a url'
      expect{event.save!}.to raise_error(/Creo que el enlace que has escrito no es correcto. ¡Casi lo tienes!/)
    end

    it "that has a valid link even if it is secure" do
      event.link = 'https://www.google.es'
      expect{event.save!}.to_not raise_error
    end

    it "that has a date in the future" do
      event.slot.datetime = DateTime.yesterday
      expect{event.save!}.to raise_error(/La fecha del evento ya ha pasado, ¡Ojo!/)
    end
  end
end
