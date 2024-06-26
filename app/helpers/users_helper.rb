module UsersHelper

  def get_user(user_id)
    return User.find(user_id)
  end
end
