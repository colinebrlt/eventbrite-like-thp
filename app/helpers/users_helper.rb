module UsersHelper
  def is_author?(user)
    current_user == user ? true : false
  end
end
