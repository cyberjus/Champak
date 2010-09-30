class Business < ActiveRecord::Base
  attr_accessible :name, :address, :town, :zipcode, :website_url
  
  has_many :coupons, :dependent => :destroy
  
  validates :name, :presence => true
  validates :town, :presence => true
  validates :zipcode, :presence => true, :length => { :maximum => 5 }
end
