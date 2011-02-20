# encoding: utf-8
require 'spec_helper'

describe UsersController do

  context "when user authentication" do

    let(:user) { stub_model(User, :id => 1234) }
    let(:auth_info) { { 'provider' => 'twitter',
                        'uid' => '1234',
                        'user_info' => {'name' => 'Alberto Peña'}} }

    before :each do
      User.stub(:create_from_authentication).and_return(user)
      @request.env['omniauth.auth'] = auth_info
    end

    it "redirects to event index" do
      get :authentication
      response.should redirect_to(events_path)
    end

    it "stores the user id in the session" do
      get :authentication
      session[:user_id].should == 1234
    end

    context "for a new user" do

      it "creates a new user in the system" do
        User.should_receive(:find_by_provider_and_uid).with('twitter', '1234').and_return(nil)
        User.should_receive(:create_from_authentication).with(auth_info).and_return(user)
        get :authentication
      end

    end

    context "for an exisiting user" do

      it "finds the user" do
        User.should_receive(:find_by_provider_and_uid).with('twitter', '1234').and_return(user)
        get :authentication
      end
    end
  end
end

