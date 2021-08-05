module UsersHelper
  def trunc_s(s, max_w_dots)
    max = max_w_dots - 3
    s.length > max ? s.slice(0..max) + "..." : s
  end

  def link_to_user(user)
    return link_to user.email, user
  end

  def link_to_users(text, args = {})
    filters = {}
    return link_to text, users_path(filters)
  end
end
