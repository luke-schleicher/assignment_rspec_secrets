module CreateUserMacros
  def submit_user(input)
    post users_url, params: { user: input }
  end
end
