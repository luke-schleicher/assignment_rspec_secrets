module CreateUserMacros

  def submit_user(input)
    process :create, params: { user: input }
    # post users_url, params: { user: input }
  end

  def update_user(user)
    process :update, params: { id: user.id, user: attributes_for(:user, name: updated_name) }
  end

  def log_in(user)
    session[:user_id] = user.id
  end

end
