require 'spec_helper'

describe "events/_event_description.haml" do

  let(:title) {stub(:title)}
  let(:event) {stub_model(Event).as_null_object}

  before do
    event.stub(:title).and_return(title)
  end

  it "class change if short event title" do
      title.stub(:length).and_return(5)
      render 'events/event_description', :event => event
      rendered.should have_selector(".event_with_one_line_title")
  end

  it "class change if long event title" do
      title.stub(:length).and_return(36)
      render 'events/event_description', :event => event
      rendered.should have_selector(".event_with_more_than_one_line_title")
  end
end
