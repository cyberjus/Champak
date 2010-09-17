class Coupon < ActiveRecord::Base
  attr_accessible :short_description, :long_description, :valid_from, :valid_until, :image
  
end
