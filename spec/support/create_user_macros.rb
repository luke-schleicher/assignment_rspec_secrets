module CreateUserMacros

  def submit_user(input)
    post users_url, params: { user: input }
  end

  def log_in(user)
    session[:user_id] = user.id
  end

end
