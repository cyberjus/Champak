class Setting < ActiveRecord::Base
  
  def self.getSetting(key)
    setting = Setting.where("key = ?", key).first()
    if setting 
      return setting.value
    else 
      return ""
    end
  end
  
  def self.setSetting(key, value)
    setting = Setting.find_or_create_by_key(key)
    setting.value = value
    setting.save
  end 
  
end
