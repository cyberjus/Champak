class Admin::SessionsController < Admin::BaseController
  layout 'admin_login'
  
  def new
    @title = "Login"
  end
  
  def create
    admin_user = AdminUser.authenticate(params[:session][:login], params[:session][:password])
    if admin_user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Login"
      render 'new'
    else
      sign_in admin_user
      redirect_to '/admin'
    end
  end
  
  def destroy
    sign_out
  	redirect_to root_path
  end

end
