module Admin::BaseHelper
  
    def admin_title
    base_title = "Champax ADMIN"
    if @title.nil?
      base_title
    else
      "#{base_title} - #{@title}"
    end 
  end
  
end
