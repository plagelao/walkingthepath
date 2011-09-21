module EventsHelper
  def user_identified?
    session[:user_id].present? or Rails.env == 'development'
  end
end
