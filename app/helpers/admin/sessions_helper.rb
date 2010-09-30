module Admin::SessionsHelper
  
  def sign_in(admin_user)
    session[:remember_token] = [admin_user.id, admin_user.salt]
    current_admin_user = admin_user
  end
  
  def sign_out
    session[:remember_token] = [nil, nil]
    self.current_admin_user = nil
  end
  
  def current_admin_user=(admin_user)
		@current_admin_user = admin_user
	end
  
  def current_admin_user
    @current_admin_user ||= user_from_remember_token
  end

  def signed_in?
    !current_admin_user.nil?
  end
  
  def deny_access
    redirect_to admin_login_path, :notice => "Please sign in to access this page."
  end
  
  private

    def user_from_remember_token
      AdminUser.authenticate_with_salt(*remember_token)
    end

    def remember_token
      session[:remember_token] || [nil, nil]
    end
  
end
