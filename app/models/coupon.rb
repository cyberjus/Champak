class Coupon < ActiveRecord::Base
  attr_accessible :business_id, :category_id, :short_description, :long_description, :valid_from, :valid_until, :image, :categories_attributes
  has_attached_file :image
  
  belongs_to :business
  belongs_to :category
  
  validates :business_id, :presence => true
  validates :short_description, :presence => true, :length => { :maximum => 250 } 
  validates :valid_from, :presence => true
  validates :valid_until, :presence => true
  
end
