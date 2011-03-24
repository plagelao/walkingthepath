#encoding: utf-8
require 'spec_helper'

describe Event do

  let(:event){Event.new({:date => 301101121000, :title => 'title', :link => 'link'})}

  it "is created for a specific date" do
    event.date.should == 301101121000
  end

  it "updates the month when the date is changed" do
    event.date = 301102121000
    event.month.should == 'Febrero'
  end

  it "updates the day when the date is changed" do
    event.date = 301101131000
    event.day.should == 13
  end

  it "updates the hour when the date is changed" do
    event.date = 301101121100
    event.time.should == '11:00'
  end

  it "shows an indefined hour when hour is set to 0000" do
    event.date = 301101120000
    event.time.should == '---'
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
      event.date = 100001010000
      expect{event.save!}.to raise_error(/La fecha del evento ya ha pasado, ¡Ojo!/)
    end
  end
end
