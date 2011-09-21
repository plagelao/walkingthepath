#encoding: utf-8
require 'spec_helper'

describe Event do

  let(:tomorrow) { Time.now + 1 }
  let(:slot) { Slot.new(:datetime => tomorrow) }
  let(:event) { Event.new({:slot => slot, :title => 'title', :link => 'http://www.link.es'}) }

  context "validates" do

    it "that has a title" do
      event.title = nil
      event.should_not be_valid
      event.error_for(:title).should == "No seas vaguete y ponle un título al evento."
    end

    it "that has a link" do
      event.link = nil
      event.should_not be_valid
      event.error_for(:link).should == "Seguro que tienes un enlace a la descripción del evento por algún lado."
    end

    it "that has a valid link" do
      event.link = 'not a url'
      event.should_not be_valid
      event.error_for(:link).should == "Creo que el enlace que has escrito no es correcto. ¡Casi lo tienes!"
    end

    it "that has a valid link even if it is secure" do
      event.link = 'https://www.google.es'
      event.should be_valid
    end

    it "that has a slot" do
      event.slot = nil
      event.should_not be_valid
    end
  end
end
