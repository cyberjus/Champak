class Business < ActiveRecord::Base
  attr_accessible :name, :address, :town, :zipcode, :website_url
  
end
