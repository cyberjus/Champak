class Admin::SettingsController < Admin::BaseController
  before_filter :authenticate
  
  def index 
    @title = "Settings"
    @skyscraper_left = Ad.find_by_id(Setting::getSetting('skyscraper_left'))
    @skyscraper_right = Ad.find_by_id(Setting::getSetting('skyscraper_right'))
  end
  
  def set_ads
    Setting.setSetting('skyscraper_left', params[:skyscraper_left])
    Setting.setSetting('skyscraper_right', params[:skyscraper_right])
    flash[:success] = "Site Ads Updated."
    redirect_to admin_settings_path
  end
  

end