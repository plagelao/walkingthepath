require 'spec_helper'

describe "events/_header.haml" do
  it "set the page title" do
    pending
    render :partial => 'header'
    response.should have_tag('header', /Let's walk the path together!/)
  end
end
