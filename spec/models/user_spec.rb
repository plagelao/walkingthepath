# encoding: utf-8
require 'spec_helper'

describe User do

  context "is created" do

    let(:auth_info) { {'provider' => 'twitter',
                       'uid' => '1234',
                       'user_info' => {'name' => 'Alberto Peña'}} }
    let(:user) { mock(:user).as_null_object }

    before :each do
      User.stub(:new).and_return(user)
    end

    it "from authentication info" do
      User.should_receive(:new).and_return(user)
      user.should_receive(:save)
      User.create_from_authentication(auth_info).should == user
    end

    it "with a name" do
      user.should_receive(:name=).with('Alberto Peña')
      User.create_from_authentication(auth_info)
    end

    it "with a provider" do
      user.should_receive(:provider=).with('twitter')
      User.create_from_authentication(auth_info)
    end

    it "with an uid" do
      user.should_receive(:uid=).with('1234')
      User.create_from_authentication(auth_info)
    end
  end

end

