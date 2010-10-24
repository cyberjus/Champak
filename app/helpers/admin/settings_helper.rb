module Admin::SettingsHelper
  
  def banner_select(type, default)
    ads = Ad.where('banner_type = ?', type).order('name').collect { |a| [a.name, a.id] }.insert(0,"")
    options_for_select(ads, default)
  end
  
end