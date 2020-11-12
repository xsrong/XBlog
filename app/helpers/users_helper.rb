module UsersHelper
  def current_user?(user_id)
    current_user&.id == user_id
  end

  def admin?(user)
    user&.role == :admin
  end

  def current_user_has_ud_permission_to?(user_id)
    current_user?(user_id) || admin?(current_user)
  end

  def display_signature(user)
    user.signature.blank? ? "no words from " + user.nickname : user.signature
  end
end
