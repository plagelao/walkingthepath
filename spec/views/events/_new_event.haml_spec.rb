#encoding: utf-8
require 'spec_helper'

describe "events/_new_event.haml" do
  it "shows an option to add new events" do
    render 'events/new_event'
    rendered.should contain("Añadir un evento")
  end
end
