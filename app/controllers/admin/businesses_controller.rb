class Admin::BusinessesController < Admin::BaseController
  before_filter :authenticate
  
  def index 
    @businesses = Business.order('name').paginate(:page => params[:page])
    @title = "Businesses"
  end
  
  def new
    @business = Business.new
    @title = "Add Business" 
  end
  
  def create 
    @business = Business.new(params[:business])
    if @business.save
      if params[:commit] = "Create and Add Coupon" 
        redirect_to new_admin_coupon_path(:business => @business.id)
      else
        flash[:success] = "Business created."
        redirect_to admin_businesses_path
      end
    else
      @title = "Add Business"
      render 'new'
    end
  end
  
  def edit
    @business = Business.find(params[:id])  
    @title = "Edit Business"
  end
  
  def update
    @business = Business.find(params[:id])
  	if @business.update_attributes(params[:business])
  		flash[:success] = "Business updated."
  		flash[:notice] = "Geocoder could not match address. This business will not be used in find by zipcode searches." if @business.lat.nil? || @business.lng.nil?
  		redirect_to admin_businesses_path
  	else
  		@title = "Edit Business"
  		render 'edit'
  	end
  end
  
  def destroy
    Business.find(params[:id]).destroy
    flash[:success] = "Business Deleted"
    redirect_to admin_businesses_path  
  end
  
end
