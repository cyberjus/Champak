class Admin::AdminUserController < Admin::BaseController
  before_filter :authenticate
  
  def edit
    @admin_user = current_admin_user
    @title = "Change Password"
  end

  def update
    @admin_user = AdminUser.find(params[:id])
  	admin_user_check = AdminUser.authenticate(@admin_user.login, params[:old_password])
  	if admin_user_check.nil?
  	  @admin_user.errors.add_to_base("Invalid Old Password Supplied.")
  	  @title = "Change Password"
    	render 'edit'
  	else
    	if @admin_user.update_attributes(params[:admin_user])
    		flash[:success] = "Password Successfully Changed"
    		redirect_to admin_root_path
    	else
    		@title = "Change Password"
    		render 'edit'
    	end
	  end
  end

end
