class UsersController < ApplicationController

    def authentication
      session[:user_id] = user_from(request.env["omniauth.auth"]).id
      redirect_to events_path
    end

    private

    def user_from(auth_info)
      User.find_by_provider_and_uid(auth_info['provider'], auth_info['uid']) || User.create_from_authentication(auth_info)
    end
end
