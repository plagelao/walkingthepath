#encoding: utf-8
require 'spec_helper'

describe "events/_authentication.haml" do
  context "no signed in" do

    it "shows an option to sign in" do
      session[:user_id] = nil
      render 'events/authentication'
      rendered.should contain("Identifícate con twitter")
    end

  end

  context "signed in" do

    let(:user) { stub(:user).as_null_object }

    before :each do
      User.stub(:find).and_return(user)
      session[:user_id] = 1234
    end

    it "does not show an option to sign in" do
      render 'events/authentication'
      rendered.should_not contain("Identifícate con twitter")
    end

    it "shows the user name" do
      user.stub(:name).and_return('Alberto')
      render 'events/authentication'
      rendered.should =~ /Alberto/
    end
  end

end

