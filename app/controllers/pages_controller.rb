class PagesController < ApplicationController
  
  def home
    @featured_coupons = Coupon.active.includes(:business).where("featured = ?", true)  
    @top_rated_coupons = Coupon.active.includes(:business).where("total_ratings <> ?", 0).order('rating DESC').limit(5)
  end
  
  def contact
    @title = "Contact"
  end
  
  def help
    @title = "Help"
  end
  
  def about
    @title = "About"
  end
  
  def for_businesses
    @title = "For Businesses"
  end
  
  def why_coupons
    @title = "Why Coupons"
  end
  
  def help_popup
    @title = "Disabling Popup Blockers"
  end
  
end
