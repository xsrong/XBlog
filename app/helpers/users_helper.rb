module UsersHelper
  def current_user?(user)
    current_user&.id == user.id
  end

  def admin?(user)
    user&.role == :admin
  end

  def current_user_has_ud_permission_to?(user)
    current_user?(user) || admin?(current_user)
  end

  def display_signature(user)
    user.signature.blank? ? "no words from " + user.nickname : user.signature
  end
end
