require 'spec_helper'

describe SiteController do

  describe "GET 'events'" do
    it "should be successful" do
      get 'events'
      response.should be_success
    end
  end

end
