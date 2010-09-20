class Admin::CouponsController < Admin::BaseController
  
  def index 
    @coupons = Coupon.paginate(:page => params[:page])
    @title = "Coupons"
  end
  
  def new
    @coupon = Coupon.new
    @title = "Add Coupons" 
  end
  
end
