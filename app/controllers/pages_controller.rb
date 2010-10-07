class PagesController < ApplicationController
  
  def home
    @featured_coupons = Coupon.where("featured = ?", true)    
  end
  
end
