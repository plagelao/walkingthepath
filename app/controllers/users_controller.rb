class UsersController < ApplicationController

  def authentication
    raise request.env["ominauth.auth"].inspect
    redirect_to events_path
  end

end
