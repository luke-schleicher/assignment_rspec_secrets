module CreateUserMacros

  def submit_user(input)
    process :create, params: { user: input }
    # post users_url, params: { user: input }
  end

  def log_in(user)
    session[:user_id] = user.id
  end

end
