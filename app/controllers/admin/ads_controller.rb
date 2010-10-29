class Admin::AdsController < Admin::BaseController
  before_filter :authenticate
  
  def index
    @ads = Ad.order('name').paginate(:page => params[:page])
    @title = "Ads"
  end
  
  def new
    @ad = Ad.new()
    @title = "Add Banner Ad" 
  end
  
  def create 
    @ad = Ad.new(params[:ad])
    if @ad.save
      redirect_to admin_settings_path
    else
      @title = "Add Banner Ad"
      render 'new'
    end
  end
  
  def edit
    @ad = Ad.find(params[:id])  
    @title = "Edit Ad"
  end
  
  def update
    @ad = Ad.find(params[:id])
  	if @ad.update_attributes(params[:ad])
  		flash[:success] = "Ad updated."
  		redirect_to admin_ads_path
  	else
  		@title = "Edit Ad"
  		render 'edit'
  	end
  end
  
  def destroy
    Ad.find(params[:id]).destroy
    flash[:success] = "Ad Deleted"
    redirect_to admin_ads_path  
  end

end