module CurrentUser

  def current_user    
    @current_user ||= User.find(session[:id]) if session[:id]
  end
end