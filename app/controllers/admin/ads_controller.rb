class Admin::AdsController < Admin::BaseController
  before_filter :authenticate
  
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

end