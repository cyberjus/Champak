class ViewsController < ApplicationController
  
  def index
  end
  
  def by_category
    @name = params[:name].tr('-', ' ').sub(' Coupons','')
    @title = "#{@name} Coupons"
    category = Category.find_by_name(@name)
    @coupon_items = Coupon.where("category_id = ?", category.id).includes(:business).order('businesses.name, short_description')  
    render 'index'
  end
  
  def by_town
    @name = params[:name].tr('-', ' ').sub(' Coupons','')
    @title = "#{@name} Coupons"
    @coupon_items = Coupon.find(:all, :conditions => ['businesses.town = ?',@name], :order => 'businesses.name, short_description', :joins => {:business =>{}} )
    render 'index'
  end
  
  def coupon
    @coupon = Coupon.find(params[:id])
    @title = "#{@coupon.business.name} Coupon"
  end
  
  def print_coupon
    @coupon = Coupon.find(params[:id])
    @coupon.print
    @title = "Coupon Found at www.Champak.net"
    render :layout => 'print'
  end
  
end
