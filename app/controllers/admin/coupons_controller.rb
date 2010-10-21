class Admin::CouponsController < Admin::BaseController
  before_filter :authenticate
  
  def index 
    @coupons = Coupon.includes(:business).order('businesses.name, coupons.created_at').paginate(:page => params[:page])
    @title = "Coupons"
  end
  
  def new
    @coupon = Coupon.new()
    set_selects
    if @business = Business.find_by_id(params[:business])
      @coupon.business = @business
    end
    @title = "Add Coupons" 
  end
  
  def create 
    @coupon = Coupon.new(params[:coupon])
    if @coupon.save
      redirect_to admin_coupons_path
    else
      set_selects
      @title = "Add Coupon"
      render 'new'
    end
  end
  
  def edit
    @coupon = Coupon.find(params[:id])
    set_selects
    @title = "Edit Coupon"
  end
  
  def update
    @coupon = Coupon.find(params[:id])
  	if @coupon.update_attributes(params[:coupon])
  		flash[:success] = "Coupon updated."
  		redirect_to admin_coupons_path
  	else
  	  set_selects
  		@title = "Edit Coupon"
  		render 'edit'
  	end
  end
  
  private 
  
  def set_selects 
    @businesses_select = Business.order('name').collect { |l| [ l.name, l.id ] }
    @categories_select = Category.order('name').collect { |l| [ l.name, l.id ] }
  end
  
end
