module HomeHelper
  def show_greeting
    user_signed_in? ? current_user.nickname : "guest"
  end

  def show_link_login_or_logout
    if authenticated_user!
      link_to("Logout", destroy_user_session_path, method: :delete)
    else
      link_to("Login", new_user_session_path)
    end
  end
end
