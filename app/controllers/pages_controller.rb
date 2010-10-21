class PagesController < ApplicationController
  
  def home
    @featured_coupons = Coupon.active.where("featured = ?", true)    
  end
  
end
