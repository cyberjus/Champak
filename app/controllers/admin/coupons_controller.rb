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
    @title = "Add Coupon" 
  end
  
  def create 
    @coupon = Coupon.new(params[:coupon])
    if @coupon.save
      if params[:tweet_this] 
        client = Twitter::Base.new(:consumer_key => CONFIG['twitter']['consumer_key'], :consumer_secret => CONFIG['twitter']['consumer_secret'], :access_key => CONFIG['twitter']['access_key'], :access_secret => CONFIG['twitter']['access_secret'] )
        begin
          client.update(tweet_worthy("New Coupon for #{@coupon.business.name} - #{@coupon.short_description}")+" http://#{request.host_with_port}/c/#{@coupon.id}")
        rescue
          flash[:error] = "Could Not Make Tweet."         
        end
      end
      flash[:success] = "Coupon created."
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
  
  def destroy
    Coupon.find(params[:id]).destroy
    flash[:success] = "Coupon Deleted"
    redirect_to admin_coupons_path  
  end
  
  private 
  
  def set_selects 
    @businesses_select = Business.order('name').collect { |l| [ l.name, l.id ] }
    @categories_select = Category.order('name').collect { |l| [ l.name, l.id ] }
  end
  
  def tweet_worthy(str)
    if str.size > 100
      str = str[0..99]
    end
    str
  end
  
end
