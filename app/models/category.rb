class Category < ActiveRecord::Base
  attr_accessible :name
  
  has_many :coupons
  
  validates :name, :presence => true
end
