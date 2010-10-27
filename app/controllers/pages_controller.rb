class PagesController < ApplicationController
  
  def home
    @featured_coupons = Coupon.active.includes(:business).where("featured = ?", true)  
    @top_rated_coupons = Coupon.active.includes(:business).where("total_ratings <> ?", 0).order('rating DESC').limit(5)
  end
  
end
