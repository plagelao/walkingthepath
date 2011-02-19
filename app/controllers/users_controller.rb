class UsersController < ApplicationController

  def authentication
    raise 'Erroraco' if request.env["ominauth.auth"].nil?
    redirect_to events_path
  end

end
