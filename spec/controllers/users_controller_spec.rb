require 'spec_helper'

describe UsersController do

  context "user authentication" do
    it "redirects to events index if correct" do
      get :authentication
      response.should redirect_to(events_path)
    end
  end
end

