class UsersController < ApplicationController

  def authentication
    puts request.env["ominauth.auth"].inspect
    redirect_to events_path
  end

end
