class User < ActiveRecord::Base

  def self.create_from_authentication(auth_info)
    user = User.new
    user.provider = auth_info['provider']
    user.uid = auth_info['uid']
    user.name = auth_info['user_info']['name']
    user.save
    user
  end

end
