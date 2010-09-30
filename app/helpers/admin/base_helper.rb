module Admin::BaseHelper
  
  def admin_title
    base_title = "Champak ADMIN"
    if @title.nil?
      base_title
    else
      "#{base_title} - #{@title}"
    end 
  end
  
end
